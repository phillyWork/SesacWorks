//
//  ProfileViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    let profileView = ProfileView()
    
    var profile: Profile?
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonTapped))
        
        profileView.chevronAgeButton.addTarget(self, action: #selector(chevronAgeButtonTapped), for: .touchUpInside)
        profileView.chevronNameButton.addTarget(self, action: #selector(chevronNameButtonTapped), for: .touchUpInside)
        profileView.chevronEmailButton.addTarget(self, action: #selector(chevronEmailButtonTapped), for: .touchUpInside)
        
        setupWithProfileData()
    }
    
    func setupWithProfileData() {
        if let profile = profile {
            profileView.ageLabel.text = "\(profile.age)"
            profileView.nameLabel.text = profile.name
            profileView.emailLabel.text = profile.email
        }
    }
    
    //MARK: - Handlers
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func chevronAgeButtonTapped() {
        let ageVC = AgeViewController()
        ageVC.age = profile?.age
        navigationController?.pushViewController(ageVC, animated: true)
    }
    
    @objc func chevronNameButtonTapped() {
        let nameVC = NameViewController()
        nameVC.name = profile?.name
        navigationController?.pushViewController(nameVC, animated: true)
    }
    
    @objc func chevronEmailButtonTapped() {
        let emailVC = EmailViewController()
        emailVC.email = profile?.email
        navigationController?.pushViewController(emailVC, animated: true)
    }
}
