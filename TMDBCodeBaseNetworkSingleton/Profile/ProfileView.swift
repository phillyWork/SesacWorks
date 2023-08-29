//
//  ProfileView.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .white
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .white
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .darkGray
        label.textColor = .white
        return label
    }()
    
    lazy var chevronNameButton = ChevronButton()
    lazy var chevronAgeButton = ChevronButton()
    lazy var chevronEmailButton = ChevronButton()
    
    override func configViews() {
        super.configViews()
        
        addSubview(nameLabel)
        addSubview(ageLabel)
        addSubview(emailLabel)
        
        addSubview(chevronNameButton)
        addSubview(chevronAgeButton)
        addSubview(chevronEmailButton)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.trailing.equalTo(self.safeAreaLayoutGuide).inset(45)
            make.height.equalTo(30)
        }
        
        chevronNameButton.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.trailing)
            make.size.equalTo(30)
            make.top.equalTo(nameLabel.snp.top)
        }
        
        
        
    }
    
}
