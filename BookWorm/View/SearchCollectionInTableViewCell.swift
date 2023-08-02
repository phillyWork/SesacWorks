//
//  SearchCollectionInTableViewCell.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/02.
//

import UIKit

protocol CollectionTableViewCellDelegate {
    func selectedCollectionTableViewCell(indexPath: IndexPath)
}

class SearchCollectionInTableViewCell: UITableViewCell {
   
    static let identifier = "SearchCollectionInTableViewCell"

    var delegate: CollectionTableViewCellDelegate?
    
    //tableView의 상단 cell 내부에 collectionView
    @IBOutlet var searchCollectionViewInTableCell: UICollectionView!
    
    var recentBooks: [Book]?
    
    let dataManager = DataManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCollectionCell()
        configCollectionView()
    }

    //collectionView에 쓰일 collectionViewCell 등록
    func registerCollectionCell() {
        let nib = UINib(nibName: SearchCollectionViewCell.identifier, bundle: nil)
        searchCollectionViewInTableCell.register(nib, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
 
    func configCollectionView() {
        searchCollectionViewInTableCell.dataSource = self
        searchCollectionViewInTableCell.delegate = self
        
        configCollectionViewLayout()
    }
    
    func configCollectionViewLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .horizontal
        
        let spacing: CGFloat = 10
        
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 5 * spacing) / 5, height: 100)
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        
        searchCollectionViewInTableCell.collectionViewLayout = flowLayout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//MARK: - Extension for CollectionView

extension SearchCollectionInTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let books = recentBooks else {
            print("Nothing to show on collectionView")
            return 0
        }
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("CollectionView in TableViewCell: \(indexPath)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        if let books = recentBooks {
            cell.book = books[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //present: UIViewController 상속받아야 가능
        //protocol로 해당 기능 구현하기
        if let delegate = delegate {
            delegate.selectedCollectionTableViewCell(indexPath: indexPath)
        }
        
//        let sb = UIStoryboard(name: "Mai", bundle: nil)
//        let detailVC = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
//        let book: Book?
//        guard let recentBooks = recentBooks else {
//            print("No data came from TableView")
//            return
//        }
//        book = recentBooks[indexPath.row]
//        print("IndexPath of collectionViewCell in section 0 of tableView: \(indexPath)")
//
//        //data 전달
//        detailVC.book = book
//        //update recentlySeenBooks
//        dataManager.addRecentlySeenBook(newBook: book)
//
//
//
//        detailVC.view.backgroundColor = UIColor(red: book!.color[0], green: book!.color[1], blue: book!.color[2], alpha: 1)
//
//        let navVC = UINavigationController(rootViewController: detailVC)
//        navVC.modalPresentationStyle = .fullScreen
        
    }
    
  
    
}

