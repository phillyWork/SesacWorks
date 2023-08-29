//
//  ProfileViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let dataManager = DataManager.shared
    
    let profileView = ProfileView()
    
    var profile: Profile?
    
    override func loadView() {
        self.view = profileView
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(emailPostObserved), name: .userEmail, object: nil)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(emailPostObserved), name: .userEmail, object: nil)
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: .userEmail, object: nil)
//    }
    
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
//        dataManager.updateProfile(newProfile: Profile(name: profileView.nameLabel.text!, age: Int(profileView.ageLabel.text!)!, email: profileView.emailLabel.text!))
        dataManager.updateProfile(newProfile: profile!)
        dismiss(animated: true)
    }
    
    @objc func chevronNameButtonTapped() {
        let nameVC = NameViewController()
        nameVC.name = profile?.name
        nameVC.completionHandler = { result in
            self.profile?.name = result
            self.profileView.nameLabel.text = result
        }
        navigationController?.pushViewController(nameVC, animated: true)
    }
    
    @objc func chevronAgeButtonTapped() {
        let ageVC = AgeViewController()
        ageVC.age = profile?.age
        ageVC.delegate = self
        navigationController?.pushViewController(ageVC, animated: true)
    }
    
    @objc func chevronEmailButtonTapped() {
        let emailVC = EmailViewController()
        emailVC.email = profile?.email
        navigationController?.pushViewController(emailVC, animated: true)
    }
    
    @objc func emailPostObserved(notification: NSNotification) {
        print(#function)
        //Any type --> typecasting
        if let newUserEmail = notification.userInfo?["newEmail"] as? String {
            profile?.email = newUserEmail
            profileView.emailLabel.text = newUserEmail
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .userEmail, object: nil)
    }
    
}

//MARK: - Extension for AgeSetupDelegate

extension ProfileViewController: AgeSetupDelegate {
    
    func receiveAge(ageText: String) {
        if let newAge = Int(ageText) {
            profile?.age = newAge
            profileView.ageLabel.text = ageText
        }
    }
    
}
