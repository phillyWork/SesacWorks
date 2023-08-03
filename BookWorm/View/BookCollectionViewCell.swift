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
    
    //초기화 이후 다시 수행 X
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        bookTitleLabel.textColor = .white
        bookTitleLabel.font = .boldSystemFont(ofSize: 20)
        bookTitleLabel.textAlignment = .center
        bookTitleLabel.backgroundColor = .clear
        
        bookRateLabel.font = .systemFont(ofSize: 12)
        bookRateLabel.textColor = .white
        bookRateLabel.textAlignment = .center
        bookRateLabel.backgroundColor = .clear
        
        bookCoverImageView.contentMode = .scaleAspectFill
        bookCoverImageView.backgroundColor = .clear
        
        likeButton.tintColor = .red
    }
        
    //cellForRowAt 수행마다 호출
    func configCell() {
        
        guard let book = book else {
            print("No data came from CollectionView")
            return
        }
        
        bookTitleLabel.text = book.title
        bookRateLabel.text = String(book.rate)
        bookCoverImageView.image = BookCoverTitle(rawValue: book.title)?.coverImage
        
        if book.like {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        self.backgroundColor = UIColor(red: book.color[0], green: book.color[1], blue: book.color[2], alpha: 1)
    }

}
