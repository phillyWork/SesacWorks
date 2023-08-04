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
    
//    let dataManager = DataManager.shared
    
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
        
        for item in books {
            print("collectionViewCell로 들어갈 제목들: ", item.title)
        }
        
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        
        if let books = recentBooks {
            cell.book = books[indexPath.row]
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //present: UIViewController 상속받아야 가능, cell에서는 불가능
        //protocol로 해당 기능 대신하도록 설정하기
        delegate?.selectedCollectionTableViewCell(indexPath: indexPath)
        collectionView.reloadData()
        
        
    }
    
      
}

