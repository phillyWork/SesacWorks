//
//  BookCell.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Kingfisher

class BookCell: UICollectionViewCell {

    static let identifier = "BookCell"
    
    var book: Book? {
        didSet {
            configureCell()
        }
    }
    
    var realmBook: BookTable? {
        didSet {
            configureRealmBook()
        }
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .white
        nameLabel.font = .boldSystemFont(ofSize: 15)
        
        priceLabel.font = .systemFont(ofSize: 13)
        priceLabel.textColor = .white
        
        likeButton.tintColor = .red
    }

    
    func configureCell() {
        
        guard let book = book else {
            print("No data from CollectionView")
            return
        }
        
        let url = URL(string: book.thumbnailURL)
        coverImageView.kf.setImage(with: url)
        
        nameLabel.text = book.title
        priceLabel.text = "\(book.price)"
        
        if book.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        self.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
        
    }
    
    func configureRealmBook() {
        guard let realmBook = realmBook else {
            print("No RealmBook")
            return
        }
        
        if let thumbnail = realmBook.thumbnailURL {
            let url = URL(string: thumbnail)
            coverImageView.kf.setImage(with: url)
        }
        
        nameLabel.text = realmBook.title
        priceLabel.text = "\(realmBook.price)"
        
        if realmBook.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        self.backgroundColor = UIColor(red: Book.randomColor()[0], green: Book.randomColor()[1], blue: Book.randomColor()[2], alpha: 1)
        
    }
    
    
}
