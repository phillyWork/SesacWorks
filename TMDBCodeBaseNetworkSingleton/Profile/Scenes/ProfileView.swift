//
//  ProfileView.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class ProfileView: BaseView {
    
    let nameLabel = DarkTextLabelWhiteText()
    let ageLabel = DarkTextLabelWhiteText()
    let emailLabel = DarkTextLabelWhiteText()
    
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
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(nameLabel.snp.horizontalEdges)
            make.height.equalTo(30)
        }
        
        chevronAgeButton.snp.makeConstraints { make in
            make.leading.equalTo(ageLabel.snp.trailing)
            make.size.equalTo(30)
            make.top.equalTo(ageLabel.snp.top)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(ageLabel.snp.horizontalEdges)
            make.height.equalTo(30)
        }
        
        chevronEmailButton.snp.makeConstraints { make in
            make.leading.equalTo(emailLabel.snp.trailing)
            make.size.equalTo(30)
            make.top.equalTo(emailLabel.snp.top)
        }
        
    }
    
}
