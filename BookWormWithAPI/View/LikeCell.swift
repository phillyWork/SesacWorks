//
//  LikeCell.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/09.
//

import UIKit
import Kingfisher
import RealmSwift

class LikeCell: UITableViewCell {

    static let identifier = "LikeCell"
    
    var realmBook: BookTable? {
        didSet {
            configRealmBookData()
        }
    }
    
    var book: Book? {
        didSet {
            configBookData()
        }
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverImageView.contentMode = .scaleToFill
        
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        dateLabel.textColor = .white
        dateLabel.font = .systemFont(ofSize: 13)
        
        priceLabel.textColor = .white
        priceLabel.font = .systemFont(ofSize: 11)
            
        likeButton.tintColor = .red
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configBookData() {
        
        guard let book = book else {
            print("No data from liked books")
            return
        }
        
        let url = URL(string: book.thumbnailURL)
        coverImageView.kf.setImage(with: url)
        
        titleLabel.text = book.title
        dateLabel.text = book.date
        priceLabel.text = "\(book.price)"
        
        if book.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        self.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
    }
    
    func configRealmBookData() {
        
        guard let realmBook = realmBook else {
            print("No data from liked books")
            return
        }
        
        if let thumbnail = realmBook.thumbnailURL {
            let url = URL(string: thumbnail)
            coverImageView.kf.setImage(with: url)
        }
                
        titleLabel.text = realmBook.title
        dateLabel.text = realmBook.date
        priceLabel.text = "\(realmBook.price)"
        
        if realmBook.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        self.backgroundColor = UIColor(red: Book.randomColor()[0], green: Book.randomColor()[1], blue: Book.randomColor()[2], alpha: 1)
    }
    
}
