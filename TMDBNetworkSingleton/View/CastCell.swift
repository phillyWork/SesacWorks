//
//  CastCell.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/12.
//

import UIKit
import Kingfisher

class CastCell: UITableViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    
    var cast: Casting? {
        didSet {
            updateData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        configUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configUI() {
        castImageView.layer.cornerRadius = 8
        castImageView.clipsToBounds = true
        
        nameLabel.textColor = .black
        nameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        roleLabel.textColor = .lightGray
        roleLabel.font = .systemFont(ofSize: 12)
        
    }
    
    func updateData() {
        
        guard let cast = cast else {
            print("No data from dataManager")
            return
        }

        nameLabel.text = cast.name
        roleLabel.text = cast.character
        
        let profileUrl = URL(string: ImageURL.profile.requestURL + cast.profilePath)
        castImageView.kf.setImage(with: profileUrl)
        
    }
    
    
    
}
