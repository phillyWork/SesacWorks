//
//  EpisodeCollectionViewCell.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import UIKit
import Kingfisher

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stillImageView: UIImageView!
    @IBOutlet weak var seasonEpisodeNumberLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var episodeOverviewLabel: UILabel!
    
    var episode: Episode? {
        didSet {
            updateUIWithData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stillImageView.contentMode = .scaleAspectFill
        
        seasonEpisodeNumberLabel.textColor = .darkGray
        seasonEpisodeNumberLabel.font = .systemFont(ofSize: 13, weight: .medium)
        
        episodeTitleLabel.textColor = .black
        episodeTitleLabel.font = .boldSystemFont(ofSize: 15)
        
        episodeOverviewLabel.textColor = .black
        episodeOverviewLabel.font = .systemFont(ofSize: 14, weight: .medium)
        episodeOverviewLabel.numberOfLines = 0
    }

    func updateUIWithData() {
        guard let episode = episode else { return }
        
        guard let stillPath = episode.stillPath else {
            print("No still path")
            return
        }
        
        let url = URL(string: ImagePath.stillPath.requestUrl + stillPath)
        stillImageView.kf.setImage(with: url)
        
        seasonEpisodeNumberLabel.text = episode.seasonEpisodeNumber
        episodeTitleLabel.text = episode.name
        episodeOverviewLabel.text = episode.overview
    }
    
    
    
}
