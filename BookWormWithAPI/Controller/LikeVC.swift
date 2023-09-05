//
//  LikeVC.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/09.
//

import UIKit
import RealmSwift

class LikeVC: UIViewController {

    let dataManager = DataManager.shared
    
    @IBOutlet weak var likeTableView: UITableView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "찜 목록"
        
        configTableView()
    }
    
    func configTableView() {
        
        let nib = UINib(nibName: LikeCell.identifier, bundle: nil)
        likeTableView.register(nib, forCellReuseIdentifier: LikeCell.identifier)
        
        likeTableView.rowHeight = 150
        
        likeTableView.delegate = self
        likeTableView.dataSource = self
        
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        
        print("LikeVC", #function)
        
        let cellBook = dataManager.getLikedBooks()[sender.tag]
        
        dataManager.removeLikeFromLike(book: cellBook, likeTag: sender.tag)
        
        likeTableView.reloadData()
        
    }

}

//MARK: - Extension for TableView Delegate, DataSource

extension LikeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let realmBooks = dataManager.getRealmHistoryBooks()
        return realmBooks.isEmpty ? dataManager.getLikedBooks().count : dataManager.getRealmHistoryBooks().filter { $0.like == true }.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeTableView.dequeueReusableCell(withIdentifier: LikeCell.identifier) as! LikeCell
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.likeButton.tag = indexPath.row
        
        if dataManager.getRealmHistoryBooks().isEmpty {
            cell.realmBook = dataManager.getRealmHistoryBooks().filter { $0.like == true }[indexPath.row]
        } else {
            cell.book = dataManager.getLikedBooks()[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: DetailVC.identifier) as! DetailVC
        
        if dataManager.getRealmHistoryBooks().isEmpty {
            let book = dataManager.getLikedBooks()[indexPath.row]
            detailVC.book = book
            
            do {
                let realm = try Realm()
                let task = BookTable(title: book.title, author: book.author, contents: book.contents, date: book.date, isbn: book.isbn, thumbnailURL: book.thumbnailURL, price: book.price, like: book.like, memo: nil)
                try realm.write {
                    realm.add(task)
                    print("Add new book to realm in like")
                }
            } catch {
                print(error)
            }
            detailVC.view.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
        } else {
            let realmBook = dataManager.getRealmHistoryBooks().filter { $0.like == true }[indexPath.row]
            detailVC.realmBook = realmBook
            detailVC.view.backgroundColor = UIColor(red: Book.randomColor()[0], green: Book.randomColor()[1], blue: Book.randomColor()[2], alpha: 1)
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
