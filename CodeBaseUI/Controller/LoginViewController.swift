//
//  LoginViewController.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "AssignmentFlix"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .red
        label.textAlignment = .center
        label.backgroundColor = .white
        return label
    }()
    
    let emailPhoneTextField: GrayTextField = {
        let tf = GrayTextField()
        tf.setPlaceholderColor(text: "이메일 주소 또는 전화번호")
        return tf
    }()
    
    let passwordTextField: GrayTextField = {
        let tf = GrayTextField()
        tf.setPlaceholderColor(text: "비밀번호")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let nicknameTextField: GrayTextField = {
        let tf = GrayTextField()
        tf.setPlaceholderColor(text: "닉네임")
        return tf
    }()
    
    let locationTextField: GrayTextField = {
        let tf = GrayTextField()
        tf.setPlaceholderColor(text: "위치")
        return tf
    }()
    
    let promotionCodeTextField: GrayTextField = {
        let tf = GrayTextField()
        tf.setPlaceholderColor(text: "추천 코드 입력")
        return tf
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(string: "회원가입")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange())
        attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 16), range: NSRange())
        button.setAttributedTitle(attributedString, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        return button
    }()
    
    let extraInfoLabel: WhiteLabel = {
        let label = WhiteLabel()
        label.setText(text: "추가 정보 입력", font: .medium, size: 13)
        return label
    }()
    
    lazy var redSwitch: UISwitch = {
        let mySwitch = UISwitch()
        mySwitch.isOn = false
        mySwitch.onTintColor = .red
        mySwitch.preferredStyle = .sliding
        return mySwitch
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configViews()
    }
    
    func configViews() {
        view.backgroundColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [emailPhoneTextField, passwordTextField, nicknameTextField, locationTextField, promotionCodeTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        let components = [nameLabel, stackView, signUpButton, extraInfoLabel, redSwitch]
        for component in components {
            view.addSubview(component)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.centerY.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.8)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.4)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(stackView.snp.horizontalEdges)
            make.height.equalTo(stackView.snp.height).multipliedBy(0.22)
            make.top.equalTo(stackView.snp.bottom).offset(10)
        }
        
        extraInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(signUpButton.snp.leading)
            make.top.equalTo(signUpButton.snp.bottom).offset(15)
            make.width.equalTo(signUpButton.snp.width).multipliedBy(0.35)
        }
        
        redSwitch.snp.makeConstraints { make in
            make.trailing.equalTo(signUpButton.snp.trailing)
            make.centerY.equalTo(extraInfoLabel.snp.centerY)
        }
    }


}
