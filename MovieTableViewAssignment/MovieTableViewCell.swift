//
//  MovieTableViewCell.swift
//  MovieTableViewAssignment
//
//  Created by Heedon on 2023/07/28.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    let dataManager = DataManager.shared

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    

    func configCell(cell row: Int) {
        let movieData = dataManager.getData()[row]
        
//        if let movieType = MovieTitle(rawValue: movieData.title) {
//            posterImageView.image = dataManager.getPosterImage(type: movieType)
//        }
        
        let movieType = MovieTitle(rawValue: movieData.title)
        //동일 UIImage return, 내부 다른 코드
        posterImageView.image = movieType?.posterImage
//        posterImageView.image = movieType?.posterImageTwo
        
        movieTitle.text = movieData.title
        movieTitle.font = .boldSystemFont(ofSize: 20)
        
        releaseDateLabel.text = movieData.releaseDate
        runtimeLabel.text = "\(movieData.runtime)분"
        rateLabel.text = "\(movieData.rate)점"
        
        overviewLabel.text = movieData.overview
        overviewLabel.numberOfLines = 5
    }

}
