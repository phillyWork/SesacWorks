//
//  LikeVC.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/09.
//

import UIKit

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
        return dataManager.getLikedBooks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = likeTableView.dequeueReusableCell(withIdentifier: LikeCell.identifier) as! LikeCell
        
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        cell.likeButton.tag = indexPath.row
        
        cell.book = dataManager.getLikedBooks()[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = sb.instantiateViewController(withIdentifier: DetailVC.identifier) as! DetailVC
        
        let book = dataManager.getLikedBooks()[indexPath.row]
        
        detailVC.book = book
        
        detailVC.view.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
