//
//  CastTableViewCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class CastTableViewCell: BaseTableViewCell {
    
    //MARK: - Properties
    
    var cast: Cast? {
        didSet {
            updateWithData()
        }
    }
    
    let castImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let roleLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
   //MARK: - Setup
    
    override func configViews() {
        super.configViews()
        
        addSubview(castImageView)
        addSubview(nameLabel)
        addSubview(roleLabel)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        castImageView.snp.makeConstraints { make in
//            make.centerY.equalTo(self.snp.centerY)
            make.verticalEdges.equalTo(self.snp.verticalEdges).inset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.width.equalTo(self.snp.width).multipliedBy(0.2)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(-15)
            make.leading.equalTo(castImageView.snp.trailing).offset(15)
            make.trailing.equalTo(self.snp.trailing).inset(15)
        }
        
        roleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(15)
            make.horizontalEdges.equalTo(nameLabel.snp.horizontalEdges)
        }
        
    }
    
    
    private func updateWithData() {
        guard let cast = cast else { return }
        
        if let profilePath = cast.profilePath, let profileUrl = URL(string: ImageUrl.profilePath.requestURL + profilePath) {
            DispatchQueue.global().async {
                do {
                    let profileData = try Data(contentsOf: profileUrl)
                    DispatchQueue.main.async {
                        self.castImageView.image = UIImage(data: profileData)
                    }
                } catch {
                    print(error)
                }
            }
        }
         
        nameLabel.text = cast.name
        roleLabel.text = cast.character
    }
    
    override func prepareForReuse() {
        castImageView.image = nil
        nameLabel.text = nil
        roleLabel.text = nil
    }
    
    
}
