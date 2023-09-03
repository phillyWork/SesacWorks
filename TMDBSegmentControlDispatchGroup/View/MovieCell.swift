//
//  MovieCell.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateRateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var movie: Movie? {
        didSet {
            setupData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .black
        
        dateRateLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        dateRateLabel.textColor = .darkGray
        
        overviewLabel.font = .systemFont(ofSize: 13, weight: .medium)
        overviewLabel.textColor = .black
        overviewLabel.numberOfLines = 0
    }

    override func prepareForReuse() {
        coverImageView.image = nil
        titleLabel.text = nil
        dateRateLabel.text = nil
        overviewLabel.text = nil
    }
    
    func setupData() {
        
        guard let movie = movie else { return }
    
        titleLabel.text = movie.cellTitle
        dateRateLabel.text = movie.dateRate
        overviewLabel.text = movie.overview
        
        guard let posterPath = movie.posterPath else { return }
        
        let url = URL.makeEndPointImageURL("w342/\(posterPath)")
        coverImageView.kf.setImage(with: URL(string: url))

    }
    
    
}
