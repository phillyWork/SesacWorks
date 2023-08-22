//
//  SearchTableViewCell.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/02.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var bookCoverImageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    @IBOutlet var bookInfoLabel: UILabel!
    
    @IBOutlet var logoImageStackViews: UIStackView!
    
    static let identifier = "SearchTableViewCell"
    
    var book: Book? {
        didSet {
            configCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookCoverImageView.clipsToBounds = true
        bookCoverImageView.layer.cornerRadius = 10
        
        bookTitleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        bookTitleLabel.textColor = .black
        
        bookInfoLabel.textColor = .lightGray
        bookInfoLabel.font = .systemFont(ofSize: 12)
    }

    func configCell() {
        guard let book = book else {
            print("Nothing from TableView")
            return
        }
        
        bookCoverImageView.image = BookCoverTitle(rawValue: book.title)?.coverImage
        bookTitleLabel.text = book.title
        bookInfoLabel.text = book.yearAndCategory
        
        //영화: networking으로 OTT에 존재 여부 확인, 존재하면 image에 할당, 없으면 hidden
        //책: networking으로 온라인 서점 존재 여부 확인, 존재하면 서점 logo image 할당, 없으면 hidden
        
        //여기서는 default로 isHidden 설정
        logoImageStackViews.isHidden = true
        
    }
    
}
