//
//  BookCollectionViewController.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import UIKit

enum DataType {
    case whole
    case search
}

class BookCollectionViewController: UICollectionViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared
    
    let searchbar = UISearchBar()
    
    //collectionView에 보여줄 data type 기준 역할
    var dataType = DataType.whole
    
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        let nib = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        configNavBar()
        configCollectionView()
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//
//        print(#function)
//
//        if searchbar.canResignFirstResponder {
//            print("Can resign Responder")
//            searchbar.resignFirstResponder()
//        } else {
//            print("Can't resign Responder")
//        }
//    }
    
    
    //MARK: - UICollectionViewDataSource
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //data type따라 type 결과물 개수만큼 보여주기
        switch dataType {
        case .whole:
            return dataManager.getTotalBooks().count
        case .search:
            return dataManager.getSearchResults().count
        }
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as! BookCollectionViewCell
    
        // Configure the cell
        let book: Book
        
        //search 결과와 일반 화면 구분
        switch dataType {
        //다 뜨게 하기: 첫 화면 or searchbar cancel 버튼 누를 경우
        case .whole:
            book = dataManager.getTotalBooks()[indexPath.row]
        //해당 search만 보여주기
        case .search:
            book = dataManager.getSearchResults()[indexPath.row]
        }
        
//        cell.configCell(book: book)
        
        //data 직접 전달, cell didSet으로 감지, configCell 메서드 수행
        cell.book = book
        
        //cell 내부의 버튼: interface action 연결 못함
        //cell은 반복 복사 --> 단순 연결: 모든 cell 영향 줌
        //tag로 구분 ~ tag 할당: action 함수 연결시 구분하기
        cell.likeButton.tag = indexPath.row
        
        //like button 누를 시, image 변화
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let book: Book
        
        //data type 따라 전달하기
        switch dataType {
        case .whole:
            book = dataManager.getTotalBooks()[indexPath.row]
        case .search:
            book = dataManager.getSearchResults()[indexPath.row]
        }
        
        //data 넘기기        
        detailVC.book = book
        
        detailVC.fromVCType = .bookCell
        
//        detailVC.title = dataManager.getTotalBooks()[indexPath.row].title
        
        //해당 cell의 backgroundColor 넘기기
//        detailVC.view.backgroundColor = collectionView.cellForItem(at: indexPath)?.backgroundColor

        //color를 struct 데이터로 추가해서 UIColor 생성 후 전달하기
        detailVC.view.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)

        
        //recentBooks에 추가하기
        dataManager.addRecentlySeenBook(newBook: book)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    //MARK: - Handlers
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        //sender.tag를 indexPath.row 값으로 할당받음
        let cellBook: Book
        
        switch dataType {
        case .whole:
            cellBook = dataManager.getTotalBooks()[sender.tag]
        case .search:
            cellBook = dataManager.getSearchResults()[sender.tag]
        }
        
        dataManager.updateBookLike(updatedBook: cellBook)
        
        collectionView.reloadData()
    }
     
    
    @IBAction func searchBarButtonTapped(_ sender: UIBarButtonItem) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let searchVC = storyboard.instantiateViewController(withIdentifier: SearchViewController.identifier) as! SearchViewController
       
        let navVC = UINavigationController(rootViewController: searchVC)
        
        navVC.modalPresentationStyle = .fullScreen
        
        present(navVC, animated: true)
    }
    

}


//MARK: - Extension for UIViewSetting

extension BookCollectionViewController: UIViewSetting {
    
    func configNavBar() {
        title = "고래밥님의 책장"
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.titleView = searchbar
        searchbar.showsCancelButton = true
        searchbar.delegate = self
    }
    
    func configCollectionView() {
        
        //collectionView drag할 경우, keyboard dismiss
        collectionView.keyboardDismissMode = .onDrag
        
        let layout = UICollectionViewFlowLayout()

        let deviceWidth = UIScreen.main.bounds.width
        let spacing: CGFloat = 15
        
        //2개 양쪽 동일 사이즈
        let deviceSize = (deviceWidth - spacing * 3) / 2
        
        layout.itemSize = CGSize(width: deviceSize, height: deviceSize)
        
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        collectionView.collectionViewLayout = layout
    }
    
    
}



//MARK: - Extension for SearchBarDelegate

extension BookCollectionViewController: UISearchBarDelegate {
    
    func searchBarResult(searchBar: UISearchBar) {
        var tempArray = [Book]()
        
        for item in dataManager.getTotalBooks() {
            if item.title.lowercased().contains(searchBar.text!.lowercased()) {
                tempArray.append(item)
            }
        }
        
        dataManager.updateSearchResults(searchResult: tempArray)
        
        //검색 결과로 보여주기
        dataType = .search
        
        collectionView.reloadData()
    }
    
    //엔터키 입력으로 입력 완료 시
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBarResult(searchBar: searchBar)
    }
    
    //취소 버튼 누를 경우
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //키보드 내리기
        searchBar.endEditing(true)
        
        //search 결과 지우기
        dataManager.updateSearchResults(searchResult: nil)
        
        //cancel 버튼 지우고 입력값 없애기
        searchBar.showsCancelButton = false
        searchBar.text = ""
        
        //전체 데이터로 보여주기
        dataType = .whole
        
        collectionView.reloadData()
    }
    
    
    //입력값 변화때마다 호출
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarResult(searchBar: searchBar)
    }
 
    
}
