//
//  SearchCollectionViewCell.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/02.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    static let identifier = "SearchCollectionViewCell"
    
    @IBOutlet var bookCoverImageView: UIImageView!
    
    var book: Book? {
        didSet {
            configCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell() {
        if let book = book {
            bookCoverImageView.image = BookCoverTitle(rawValue: book.title)?.coverImage
        }
    }

}
