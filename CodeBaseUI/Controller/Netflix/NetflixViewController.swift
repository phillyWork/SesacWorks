//
//  NetflixViewController.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit
import SnapKit

class NetflixViewController: UIViewController {

    //MARK: - Properties
    
    let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "5")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let blackGradiationBackgroundView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "background")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let netflixLogo: WhiteLabel = {
        let label = WhiteLabel()
        label.setText(text: "N", font: .bold, size: 30)
        label.textAlignment = .center
        return label
    }()
    
    lazy var tvButton: WhiteImageButton = {
        let button = WhiteImageButton()
        button.setTitle("TV프로그램", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    lazy var movieButton: WhiteImageButton = {
        let button = WhiteImageButton()
        button.setTitle("영화", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    lazy var pinnedContentsButton: WhiteImageButton = {
        let button = WhiteImageButton()
        button.setTitle("내가 찜한 컨텐츠", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    lazy var myPinnedContentsButton: WhiteImageButton = {
        let button = WhiteImageButton()
        button.setupTitleAndImageTogether(type: .light, size: 12, title: "내가 찜한 컨텐츠", imageName: "check")
        return button
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: PlayButton.normal.rawValue), for: .normal)
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var infoButton: WhiteImageButton = {
        let button = WhiteImageButton()
        button.setupTitleAndImageTogether(type: .light, size: 12, title: "정보", imageName: "info")
        return button
    }()
    
    let previewLabel: WhiteLabel = {
        let label = WhiteLabel()
        label.setText(text: "미리보기", font: .bold, size: 15)
        label.textAlignment = .center
        return label
    }()
    
    lazy var circleOne: CircleButton = {
        let button = CircleButton()
        button.setImage(UIImage(named: "1"), for: .normal)
        return button
    }()
    
    lazy var circleTwo: CircleButton = {
        let button = CircleButton()
        button.setImage(UIImage(named: "2"), for: .normal)
        return button
    }()
    
    lazy var circleThree: CircleButton = {
        let button = CircleButton()
        button.setImage(UIImage(named: "3"), for: .normal)
        return button
    }()
    
    let viewModel = NetflixViewModel()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
        
        viewModel.isTapped.bind { bool in
            let string = bool ? PlayButton.highlighted.rawValue : PlayButton.normal.rawValue
            self.playButton.setImage(UIImage(named: string), for: .normal)
        }
    }
    
    func configViews() {

        title = "navigationbar starts"
        
        let components = [backgroundImage, blackGradiationBackgroundView, netflixLogo, tvButton, movieButton, pinnedContentsButton, playButton, myPinnedContentsButton, infoButton, circleOne, circleTwo, circleThree, previewLabel]
        
        for component in components {
            view.addSubview(component)
        }
    
        configUpSide()
        configMiddle()
        configBottom()
    }
    
    
    func configUpSide() {
    
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blackGradiationBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        netflixLogo.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(netflixLogo.snp.width).multipliedBy(1.2)
        }
        
        tvButton.snp.makeConstraints { make in
            make.centerY.equalTo(netflixLogo.snp.centerY)
            make.leading.equalTo(netflixLogo.snp.trailing).offset(20)
            make.height.equalTo(netflixLogo.snp.height).multipliedBy(0.2)
        }
        
        movieButton.snp.makeConstraints { make in
            make.centerY.equalTo(netflixLogo.snp.centerY)
            make.leading.equalTo(tvButton.snp.trailing).offset(15)
            make.height.equalTo(tvButton.snp.height)
        }
        
        pinnedContentsButton.snp.makeConstraints { make in
            make.centerY.equalTo(netflixLogo.snp.centerY)
            make.leading.equalTo(movieButton.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(tvButton.snp.height)
        }
    }
    
    func configMiddle() {
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.25)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        myPinnedContentsButton.snp.makeConstraints { make in
            make.centerY.equalTo(playButton.snp.centerY)
            make.leading.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(25)
            make.trailing.equalTo(playButton.snp.leading).offset(-30)
        }
        
        infoButton.snp.makeConstraints { make in
            make.centerY.equalTo(playButton.snp.centerY)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide).inset(25)
            make.leading.equalTo(playButton.snp.trailing).offset(30)
        }
    }

    
    func configBottom() {
        
        circleTwo.snp.makeConstraints { make in
            make.centerX.equalTo(playButton.snp.centerX)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
//            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(circleTwo.snp.width)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        circleOne.snp.makeConstraints { make in
            make.centerY.equalTo(circleTwo.snp.centerY)
            make.size.equalTo(circleTwo.snp.size)
            make.trailing.equalTo(circleTwo.snp.leading).offset(-10)
        }
        
        circleThree.snp.makeConstraints { make in
            make.centerY.equalTo(circleTwo.snp.centerY)
            make.size.equalTo(circleTwo.snp.size)
            make.leading.equalTo(circleTwo.snp.trailing).offset(10)
        }
        
        previewLabel.snp.makeConstraints { make in
            make.leading.equalTo(netflixLogo.snp.leading)
            make.height.equalTo(24)
            make.bottom.equalTo(circleTwo.snp.top).offset(-10)
        }
        
        DispatchQueue.main.async {
            self.circleTwo.layer.cornerRadius = self.circleTwo.frame.width / 2
            self.circleOne.layer.cornerRadius = self.circleTwo.layer.cornerRadius
            self.circleThree.layer.cornerRadius = self.circleTwo.layer.cornerRadius
        }
        
//        circleTwo.layer.cornerRadius = circleTwo.frame.width / 2
//        print("corner: \(circleTwo.layer.cornerRadius)")
        
//        circleTwo.layer.cornerRadius = (view.frame.width * 0.3) / 2
//        print("corner: \(circleTwo.layer.cornerRadius)")
//        print("frame: \(circleTwo.snp.width)")
        
//        circleOne.layer.cornerRadius = circleTwo.layer.cornerRadius
//        circleThree.layer.cornerRadius = circleTwo.layer.cornerRadius
        
    }
    
    
    //MARK: - Handlers
    
    @objc func playButtonTapped(sender: UIButton) {
//        navigationController?.pushViewController(LoginViewController(), animated: true)
//        transition(transitionType: .push, viewController: LoginViewController.self)
        
        viewModel.isTapped.value.toggle()
        
    }

}
