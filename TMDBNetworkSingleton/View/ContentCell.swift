//
//  ContentCell.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import UIKit
import Kingfisher

class ContentCell: UICollectionViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var backPathImageView: UIImageView!
    @IBOutlet weak var rateDetailLabel: UILabel!
    @IBOutlet weak var ratePointLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var indicatorImageView: UIImageView!
    
//    var movie: Movie? {
//        didSet {
//            updateData()
//        }
//    }
    
    var movie: Result? {
        didSet {
            updateData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configLabel()
        configShadow()
        configView()
        configImageView()
    }
    
    func configLabel() {
        dateLabel.textColor = .darkGray
        dateLabel.font = .systemFont(ofSize: 12)
        
        tagLabel.textColor = .black
        tagLabel.font = .boldSystemFont(ofSize: 15)
        
        rateDetailLabel.text = "평점"
        rateDetailLabel.textColor = .white
        rateDetailLabel.font = .systemFont(ofSize: 11)
        rateDetailLabel.backgroundColor = .systemIndigo
        rateDetailLabel.textAlignment = .center
        
        ratePointLabel.textColor = .black
        ratePointLabel.font = .systemFont(ofSize: 11)
        ratePointLabel.textAlignment = .center
        ratePointLabel.backgroundColor = .white
        
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 14)
        
        detailLabel.text = "자세히 보기"
        detailLabel.textColor = .black
        detailLabel.font = .systemFont(ofSize: 12)
    }
    
    func configShadow() {
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
    }
    
    func configView() {
        backView.clipsToBounds = true
        backView.layer.cornerRadius = 10
        
        lineView.backgroundColor = .black
        
    }
    
    func configImageView() {
        backPathImageView.contentMode = .scaleAspectFill
        indicatorImageView.image = UIImage(systemName: "chevron.right")
    }

    
    func updateData() {
//        guard let movie = movie else {
//            print("No data from datamanager")
//            return
//        }
//
//        dateLabel.text = movie.releaseDate
//        var genreText = [String]()
//        for id in movie.genreIds {
//            if let genreName = GenreIds(rawValue: id)?.genreName {
//                genreText.append("#\(genreName) ")
//            } else {
//                print("Can't find this \(id) from genre")
//            }
//        }
//        tagLabel.text = genreText.joined()
//        ratePointLabel.text = "\(round(movie.rate*100)/100)"
//        let backUrl = URL(string: ImageURL.backPath.requestURL + movie.backdropPath)
//        backPathImageView.kf.setImage(with: backUrl)
//        titleLabel.text = movie.title
        
        
        //with decodable
        guard let movie = movie else {
            print("No data from datamanager")
            return
        }
        
        dateLabel.text = movie.releaseDate
        var genreText = [String]()
        for id in movie.genreIDS {
            if let genreName = GenreIds(rawValue: id)?.genreName {
                genreText.append("#\(genreName) ")
            } else {
                print("Can't find this \(id) from genre")
            }
        }
        tagLabel.text = genreText.joined()
        
        ratePointLabel.text = "\(round(movie.voteAverage*100)/100)"
        let backUrl = URL(string: ImageURL.backPath.requestURL + movie.backdropPath)
        backPathImageView.kf.setImage(with: backUrl)
        titleLabel.text = "\(movie.title)(\(movie.originalTitle))"
    }
    
}

