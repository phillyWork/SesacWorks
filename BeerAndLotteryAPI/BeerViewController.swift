//
//  ViewController.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {

    //MARK: - Prooperties
    
    @IBOutlet weak var recommendationButton: UIButton!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configUI()
    }
    
    func callRequestToBeer() {
        
        let url = "https://api.punkapi.com/v2/beers/random"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)[0]
//                print("JSON: \(json)")
                
                self.nameLabel.text = json["name"].stringValue
                self.descriptionLabel.text = json["description"].stringValue

                let imageUrlString = json["image_url"].stringValue
                let imageUrl = URL(string: imageUrlString)
                self.coverImageView.kf.setImage(with: imageUrl)

                self.nameLabel.isHidden = false
                self.descriptionLabel.isHidden = false
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }

    
    //MARK: - API
    
    @IBAction func recoomendationButtonTapped(_ sender: UIButton) {
        callRequestToBeer()
    }
    
    

}

//MARK: - Extension for UI

extension BeerViewController {
    
    func configUI() {
        configButton()
        configImageView()
        configLabel()
    }
    
    func configButton() {
        recommendationButton.setTitle("추천해주세요", for: .normal)
        recommendationButton.setTitleColor(.black, for: .normal)
        recommendationButton.backgroundColor = .yellow
    }
    
    func configImageView() {
        coverImageView.contentMode = .scaleAspectFit
    }
    
    func configLabel() {
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        nameLabel.isHidden = true
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .darkGray
        descriptionLabel.font = .systemFont(ofSize: 13, weight: .medium)
        descriptionLabel.isHidden = true
    }
    
}
