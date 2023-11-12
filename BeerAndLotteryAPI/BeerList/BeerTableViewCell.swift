//
//  BeerTableViewCell.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Kingfisher

class BeerTableViewCell: UITableViewCell {

    static let identifier = "BeerTableViewCell"
    
    var beer: Beer? {
        didSet {
            configBeer()
        }
    }
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        coverImageView.contentMode = .scaleToFill
        
        beerNameLabel.font = .boldSystemFont(ofSize: 14)
        beerNameLabel.textColor = .black
        beerNameLabel.textAlignment = .center
        
        beerDescriptionLabel.font = .systemFont(ofSize: 12, weight: .medium)
        beerDescriptionLabel.textColor = .black
        beerDescriptionLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configBeer() {
        
        if let beer = beer {
            
            let url = URL(string: beer.imageString)
            coverImageView.kf.setImage(with: url)
                        
            beerNameLabel.text = beer.name
            beerDescriptionLabel.text = beer.description
        }
    }
    
    
}
