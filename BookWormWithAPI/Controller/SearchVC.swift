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
        
        title = "검색 결과"
        
        configSearchBar()
        configCollectionView()
        
        callRequest(query: "야구", page: 1)
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
                        let contents = data["contents"].stringValue
                        let isbn = data["isbn"].stringValue
                        let date = data["datetime"].stringValue
                        let thumbnail = data["thumbnail"].stringValue
                        let price = data["price"].intValue
                        
                        let book = Book(title: title, authors: authors, contents: contents, isbn: isbn, date: date, thumbnailURL: thumbnail, price: price, like: false, color: Book.randomColor())
                        
                        self.dataManager.addSearchBook(book: book)
                    }
                    
                    print(self.dataManager.getBooks())
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
        
        let cellBook = dataManager.getSearchBooks()[sender.tag]
        
        if cellBook.like {
            dataManager.removeLikeFromSearch(book: cellBook, searchTag: sender.tag)
        } else {
            dataManager.addLikeFromSearch(book: cellBook, searchTag: sender.tag)
        }
        
        mainCollectionView.reloadData()
    }

}

//MARK: - Extension for CollectionView Delegate, DataSource, DataSourcePrefetching

extension SearchVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.getSearchBooks().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        
        cell.likeButton.tag = indexPath.row
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.book = dataManager.getSearchBooks()[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if dataManager.getSearchBooks().count - 1 == indexPath.row && dataManager.getPageNum() < 50 && !dataManager.getCurrentIsEnd() {
                dataManager.addPageNumber()
                callRequest(query: searchBar.text!, page: dataManager.getPageNum())
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(identifier: DetailVC.identifier) as! DetailVC
        
        let book = dataManager.getSearchBooks()[indexPath.row]
        
        detailVC.book = book
        
        detailVC.view.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: - Extension for SearchBar Delegate

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.dataManager.removeSearchList()
        
        self.dataManager.addPageNumber()
        
        view.endEditing(true)
        
        guard let query = searchBar.text else { return }
        
        callRequest(query: query, page: dataManager.getPageNum())
        
        
        
    }
    
    
    
    
}
