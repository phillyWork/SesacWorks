//
//  SearchViewController.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import UIKit

class SearchViewController: UIViewController {

    //MARK: - Properties
    
    let dataManager = DataManager.shared
    
    static let identifier = "SearchViewController"
    
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configSearchNavBar()
        configTableView()
//        configCollectionView()
    }
    
    func configSearchNavBar() {
        navigationItem.title = "둘러보기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    func configTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        //cell for collectionView in tableViewCell
        let collectionNib = UINib(nibName: SearchCollectionInTableViewCell.identifier, bundle: nil)
        tableView.register(collectionNib, forCellReuseIdentifier: SearchCollectionInTableViewCell.identifier)
        
        //cell for normal tableView
        let tableCellNib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(tableCellNib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        
//        tableView.rowHeight = 100
    }
    
    //MARK: - Handlers
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }

}

//MARK: - UITableView Extensions

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    //최근 본 작품 데이터 저장 필요
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataManager.getTotalBooks().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCollectionInTableViewCell.identifier) as! SearchCollectionInTableViewCell
            
            //SearchVC가 delegate 작동 인지해야 함
            cell.delegate = self
            
            cell.recentBooks = dataManager.getRecentlySeenBooks()
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
            
            cell.book = dataManager.getTotalBooks()[indexPath.row]
            
            return cell
        }
    }
    
    //tableViewCell 내 collectionView 터치가 먹지 않음
    //delegate로 collectionView에서 터치 시, present 처리하도록
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //section이 1인 영역만 터치 먹음
        let detailVC = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        var book: Book?
        
        //networking 시, 클로저로 묶어서 작동하도록 해야할 필요 보임
//        if indexPath.section == 0 {
//            book = dataManager.getRecentlySeenBooks()[indexPath.row]
//            print("IndexPath of collectionView in section 0: \(indexPath)")
//        } else {
//            book = dataManager.getTotalBooks()[indexPath.row]
//            print("IndexPath of collectionView in section 1: \(indexPath)")
//        }
        
        
        book = dataManager.getTotalBooks()[indexPath.row]
        
        //data 전달
        detailVC.book = book
        //update recentlySeenBooks
        dataManager.addRecentlySeenBook(newBook: book)
        
        detailVC.view.backgroundColor = UIColor(red: book!.color[0], green: book!.color[1], blue: book!.color[2], alpha: 1)
        
        let navVC = UINavigationController(rootViewController: detailVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
        //탭한 row 선택 해제하기
        tableView.reloadRows(at: [indexPath], with: .none)
        
        //section 1을 누르면 section 0 최근 목록이 UI에 update가 되어야 함
        
        //작동하다 말다 하는 코드들
//        if indexPath.section != 0 {
//            tableView.reloadSections([indexPath[0]], with: .none)
//            tableView.reloadSections([indexPath.section-1], with: .none)
//        }
        
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "최근 본 작품"
        } else {
            return "요즘 인기 작품"
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else {
            return 150
        }
    }
}

//MARK: - Protocol for CollectionViewCell presentation

extension SearchViewController: CollectionTableViewCellDelegate {
    
    func selectedCollectionTableViewCell(indexPath: IndexPath) {
        
        let book = dataManager.getRecentlySeenBooks()[indexPath.row]

        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(identifier: DetailViewController.identifier) as! DetailViewController
        
        detailVC.book = book
        detailVC.view.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
        
        dataManager.addRecentlySeenBook(newBook: book)
        
        let navVC = UINavigationController(rootViewController: detailVC)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true)
        
        //collectionView 누르면 reload, 바뀐 data 적용, 순서 재배치해서 다시 그림
        tableView.reloadSections([indexPath.section], with: .automatic)
    }
    
    
}
