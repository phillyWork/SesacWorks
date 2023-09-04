//
//  SeasonCollectionReusableView.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import UIKit
import Kingfisher

class SeasonCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var season: Season? {
        didSet {
            updateUIViaData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 15)
        
        detailLabel.textColor = .darkGray
        detailLabel.font = .systemFont(ofSize: 14, weight: .regular)
        
        rateLabel.textColor = .darkGray
        rateLabel.font = .systemFont(ofSize: 13, weight: .medium)
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
        titleLabel.text = nil
        detailLabel.text = nil
        rateLabel.text = nil
    }
    
    func updateUIViaData() {
        guard let season = season else { return }
        
        let url = URL(string: ImagePath.posterPath.requestUrl + season.posterPath)
        posterImageView.kf.setImage(with: url)
        
        titleLabel.text = season.name
//        detailLabel.text = season.detail
        
        let rate = round(season.voteAverage*100)/100
        rateLabel.text = "\(rate)"
    }
    
}
