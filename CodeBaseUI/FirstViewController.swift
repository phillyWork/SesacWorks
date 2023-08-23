//
//  ViewController.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/22.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    lazy var mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "map"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    lazy var giftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gift"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    lazy var profileButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "person.crop.circle.fill"), for: .normal)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        button.backgroundColor = .red
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        label.text = "MY NAME"
        label.backgroundColor = .red
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "자기 소개를 해주세요"
        label.textColor = .white
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.backgroundColor = .red
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.backgroundColor = .lightGray
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()

    let profileSetupButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        return button
    }()
    
    let kakaoTalkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        
        button.addTarget(self, action: #selector(kakaoTalkButtonTapped), for: .touchUpInside)
        
        return  button
    }()
    
    let kakaoStoryButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "text.justify.leading"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .red
        
        button.addTarget(self, action: #selector(kakaoStoryButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 편집"
        label.textColor = .white
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.backgroundColor = .red
        return label
    }()
    
    let kakaoTalkLabel: UILabel = {
        let label = UILabel()
        label.text = "나와의 채팅"
        label.textColor = .white
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.backgroundColor = .red
        return label
    }()
    
    let kakaoStoryLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오스토리"
        label.textColor = .white
        label.font = .systemFont(ofSize: 11, weight: .light)
        label.backgroundColor = .red
        return label
    }()
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemYellow

        configUI()
    }
    
    func configUI() {
        
        let components = [closeButton, settingButton, mapButton, giftButton, profileButton, nameLabel, descriptionLabel, lineView, profileSetupButton, kakaoTalkButton, kakaoStoryButton, profileLabel, kakaoTalkLabel, kakaoStoryLabel]
        
        components.forEach { view.addSubview($0) }
        
        configConstraints()
    }
    
    func configConstraints() {
        
        //at the top
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.1)
            make.height.equalTo(closeButton.snp.width)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.top)
            make.size.equalTo(closeButton.snp.size)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        mapButton.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.top)
            make.size.equalTo(closeButton.snp.size)
            make.trailing.equalTo(settingButton.snp.leading).offset(-10)
            
        }
        
        giftButton.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.top)
            make.size.equalTo(closeButton.snp.size)
            make.trailing.equalTo(mapButton.snp.leading).offset(-10)
        }
        
        //profile
        profileButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(profileButton.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(profileButton.snp.centerX)
            make.top.equalTo(profileButton.snp.bottom).offset(10)
            make.height.equalTo(24)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalTo(nameLabel.snp.centerX)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.height.equalTo(21)
        }
        
        lineView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.height.equalTo(1)
        }
        
        //bottom of lineView
        
        profileSetupButton.snp.makeConstraints { make in
            make.centerX.equalTo(lineView.snp.centerX)
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(profileSetupButton.snp.width)
        }
        
        kakaoTalkButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.size.equalTo(profileSetupButton.snp.size)
            make.trailing.equalTo(profileSetupButton.snp.leading).offset(-30)
        }
                
        kakaoStoryButton.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(30)
            make.size.equalTo(profileSetupButton.snp.size)
            make.leading.equalTo(profileSetupButton.snp.trailing).offset(30)
        }
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(profileSetupButton.snp.bottom).offset(15)
            make.centerX.equalTo(profileSetupButton.snp.centerX)
        }
        
        kakaoTalkLabel.snp.makeConstraints { make in
            make.top.equalTo(kakaoTalkButton.snp.bottom).offset(15)
            make.centerX.equalTo(kakaoTalkButton.snp.centerX)
        }
        
        kakaoStoryLabel.snp.makeConstraints { make in
            make.top.equalTo(kakaoStoryButton.snp.bottom).offset(15)
            make.centerX.equalTo(kakaoStoryButton.snp.centerX)
        }
        
        
    }
    
    
    //MARK: - Handlers
    
    @objc func kakaoTalkButtonTapped() {
        present(SecondViewController(), animated: true)
    }
    
    @objc func kakaoStoryButtonTapped() {
        present(ThirdViewController(), animated: true)
    }
    
    
}

