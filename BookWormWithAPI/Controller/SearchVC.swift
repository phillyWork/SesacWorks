//
//  ViewController.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchVC: UIViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared

    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "최근 검색 결과"
        
        configSearchBar()
        configCollectionView()
        
//        callRequest(query: "야구", page: dataManager.getPageNum())
//        do {
//            dataManager.fetchRealmHistoryBooks()
//            print(dataManager.getRealmHistoryBooks())
//        } catch {
//            print(error)
//        }
        
        dataManager.getSchemaVersion()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //detail --> search: realm 보여주기
        dataManager.removeSearchList()
        self.mainCollectionView.reloadData()
    }

    func configSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "검색할 내용을 입력해주세요"
    }
    
    func configCollectionView() {
        
        let nib = UINib(nibName: BookCell.identifier, bundle: nil)
        mainCollectionView.register(nib, forCellWithReuseIdentifier: BookCell.identifier)
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.prefetchDataSource = self
        
        configCollectionViewLayout()
    }
    
    func configCollectionViewLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 10
        
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 3 * spacing)/2, height: 180)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        mainCollectionView.collectionViewLayout = layout
    }
    
    //MARK: - API
    
    func callRequest(query: String, page: Int) {
        
        //encoding 종류 다양함 (% 문자 처리 관련)
        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Cannot encode text!")
            return
        }
        
//        pageable_count    Integer    중복된 문서를 제외하고, 처음부터 요청 페이지까지의 노출 가능 문서 수
//        is_end    Boolean    현재 페이지가 마지막 페이지인지 여부, 값이 false면 page를 증가시켜 다음 페이지를 요청할 수 있음
    
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchText)"
        
        //header에 authorization key를 넣는 경우
        //dictionary 형태, key-value로 넣기
        //HTTPHeaders type 맞게 설정
        let header: HTTPHeaders = ["Authorization": APIKey.kakaoBookAPI]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print(json)
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                    self.dataManager.updateIsEnd(value: json["meta"]["is_end"].boolValue)
                    
                    let dataArray = json["documents"].arrayValue
                    for data in dataArray {
                        let title = data["title"].stringValue
                        let authors = data["authors"].arrayObject as! [String]
                        let author = authors.isEmpty ? "" : authors[0]
                        print("authors: \(authors) and author: \(author)")
                        let contents = data["contents"].stringValue
                        let isbn = data["isbn"].stringValue
                        let date = data["datetime"].stringValue
                        let thumbnail = data["thumbnail"].stringValue
                        let price = data["price"].intValue

                        //realm struct와 기존 struct 합쳐서 활용?
                        //DTO 활용
                        let bookForRealm = BookTable(title: title, author: author, contents: contents, date: date, isbn: isbn, thumbnailURL: thumbnail, price: price, like: false, memo: nil)
                        
                        
                        
                        let book = Book(title: title, author: author, contents: contents, isbn: isbn, date: date, thumbnailURL: thumbnail, price: price, like: false, color: Book.randomColor())
                        self.dataManager.addSearchBook(book: book)
                    }
                    
//                    print(self.dataManager.getBooks())
                    self.mainCollectionView.reloadData()
                } else {
                    print("문제 발생. 다시 시도해주세요.")
                }
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        print("SearchVC", #function)
        
        if dataManager.getSearchBooks().isEmpty {
            let realmCellBook = dataManager.fetchRealmHistoryBooks()[sender.tag]
//            let realmCellBook = dataManager.getRealmHistoryBooks()[sender.tag]
            realmCellBook.like.toggle()

            //upsert
//            dataManager.updateRealmHistoryBooks(task: ["_id": realmCellBook._id,
//                                                       "title": realmCellBook.title,
//                                                       "author": realmCellBook.author,
//                                                       "contents": realmCellBook.contents,
//                                                       "date": realmCellBook.date,
//                                                       "isbn": realmCellBook.isbn,
//                                                       "thumbnailURL": realmCellBook.thumbnailURL,
//                                                       "price": realmCellBook.price,
//                                                       "like": realmCellBook.like,
//                                                       "memo": realmCellBook.memo],
//                                                type: .upsert)
            
            //partial
            dataManager.updateRealmHistoryBooks(attributes: ["_id": realmCellBook._id, "like": realmCellBook.like], type: .partial)
        } else {
            let cellBook = dataManager.getSearchBooks()[sender.tag]
            if cellBook.like {
                dataManager.removeLikeFromSearch(book: cellBook, searchTag: sender.tag)
            } else {
                dataManager.addLikeFromSearch(book: cellBook, searchTag: sender.tag)
            }
        }
    
        mainCollectionView.reloadData()
    }
    
}

//MARK: - Extension for CollectionView Delegate, DataSource, DataSourcePrefetching

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let searchBooks = dataManager.getSearchBooks()
        return searchBooks.isEmpty ? dataManager.fetchRealmHistoryBooks().count : searchBooks.count
//        return searchBooks.isEmpty ? dataManager.getRealmHistoryBooks().count : searchBooks.count
//        let realmBooks = dataManager.getRealmHistoryBooks()
//        return realmBooks.isEmpty ? dataManager.getSearchBooks().count : realmBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        
        cell.likeButton.tag = indexPath.row
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        if dataManager.getSearchBooks().isEmpty {
            let realmBook = dataManager.fetchRealmHistoryBooks()[indexPath.row]
//            let realmBook = dataManager.getRealmHistoryBooks()[indexPath.row]
            cell.realmBook = realmBook
            
            //instead of doing another image networking, bring image file from Documents filepath
            if let thumbnail = loadFromDocument(fileName: "philllyy_\(realmBook._id).jpg") {
                print("getting image file success!")
                cell.coverImageView.image = thumbnail
            }
        } else {
            cell.book = dataManager.getSearchBooks()[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if !dataManager.getSearchBooks().isEmpty {
                if dataManager.getSearchBooks().count - 1 == indexPath.row && dataManager.getPageNum() < 50 && !dataManager.getCurrentIsEnd() {
                    dataManager.addPageNumber()
                    callRequest(query: searchBar.text!, page: dataManager.getPageNum())
                }
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(identifier: DetailVC.identifier) as! DetailVC
        
        if dataManager.getSearchBooks().isEmpty {
            let realmBook = dataManager.fetchRealmHistoryBooks()[indexPath.row]
//            let realmBook = dataManager.getRealmHistoryBooks()[indexPath.row]
            detailVC.realmBook = realmBook
            detailVC.view.backgroundColor = UIColor(red: Book.randomColor()[0], green: Book.randomColor()[1], blue: Book.randomColor()[2], alpha: 1)
        } else {
            let book = dataManager.getSearchBooks()[indexPath.row]
            detailVC.book = book
            detailVC.view.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
            
            let cell = collectionView.cellForItem(at: indexPath) as! BookCell
            guard let image = cell.coverImageView.image else { return }
            
            //realm에 저장, 해당 image 따로 Documents 폴더에 저장
            let task = BookTable(title: book.title, author: book.author, contents: book.contents, date: book.date, isbn: book.isbn, thumbnailURL: book.thumbnailURL, price: book.price, like: book.like, memo: nil)
            
            dataManager.addNewBookToRealmHistoryBooks(book: task)
            saveToDocument(fileName: "philllyy_\(task._id).jpg", data: image)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: - Extension for SearchBar Delegate

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.dataManager.removeSearchList()
        self.dataManager.resetPageNum()
//        self.dataManager.addPageNumber()
        
        view.endEditing(true)
        
        guard let query = searchBar.text else { return }
        
        callRequest(query: query, page: dataManager.getPageNum())
        
        searchBar.text = ""
    }
    
    
    
    
}
