//
//  BookCollectionViewCell.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookRateLabel: UILabel!
    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    var book: Book? {
        didSet {
            configCell()
        }
    }
    
    static let identifier = "BookCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell() {
        
        guard let book = book else {
            print("No data came from CollectionView")
            return
        }
        
        randomBackgroundColor()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        bookTitleLabel.text = book.title
        bookTitleLabel.textColor = .white
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.backgroundColor = .clear
        
        bookRateLabel.text = String(book.rate)
        bookRateLabel.font = .systemFont(ofSize: 12)
        bookRateLabel.textColor = .white
        bookRateLabel.textAlignment = .center
        bookRateLabel.backgroundColor = .clear
        
        bookCoverImageView.image = BookCoverTitle(rawValue: book.title)?.coverImage
        bookCoverImageView.contentMode = .scaleAspectFill
        bookCoverImageView.backgroundColor = .clear
        
        book.like ? likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal) : likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = .red
    }
    
    func randomBackgroundColor() {
        let cgRed = CGFloat.random(in: 0...255)/255
        let cgGreen = CGFloat.random(in: 0...255)/255
        let cgBlue = CGFloat.random(in: 0...255)/255
        
        self.backgroundColor = UIColor(cgColor: CGColor(red: cgRed, green: cgGreen, blue: cgBlue, alpha: 1))
    }
    
}
