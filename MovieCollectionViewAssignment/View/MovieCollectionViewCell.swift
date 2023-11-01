//
//  MovieCollectionViewCell.swift
//  MovieCollectionViewAssignment
//
//  Created by Heedon on 2023/07/31.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieRateLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(movie: Movie) {
        
        randomBackgroundColor()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        movieTitleLabel.text = movie.title
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .boldSystemFont(ofSize: 20)
        movieTitleLabel.textAlignment = .center
        movieRateLabel.backgroundColor = .clear
        
        movieRateLabel.text = String(movie.rate)
        movieRateLabel.font = .systemFont(ofSize: 12)
        movieRateLabel.textColor = .white
        movieRateLabel.textAlignment = .center
        movieRateLabel.backgroundColor = .clear
        
        moviePosterImageView.image = MoviePosterTitle(rawValue: movie.title)?.posterImage
        moviePosterImageView.contentMode = .scaleAspectFill
        moviePosterImageView.backgroundColor = .clear
    }
    
    func randomBackgroundColor() {
        let cgRed = CGFloat.random(in: 0...255)/255
        let cgGreen = CGFloat.random(in: 0...255)/255
        let cgBlue = CGFloat.random(in: 0...255)/255
        
        self.backgroundColor = UIColor(cgColor: CGColor(red: cgRed, green: cgGreen, blue: cgBlue, alpha: 1))
        
    }
    
}
