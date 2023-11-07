//
//  LoginViewController.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    //MARK: - Properties
    
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
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.isEnabled = false
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
    
    let resultLabel: WhiteLabel = {
        let label = WhiteLabel()
        label.setText(text: "로그인 할 수 없습니다", font: .medium, size: 12)
        return label
    }()
        
    let viewModel = LoginViewModel()

    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configViews()
        
        bindData()
    }
    
    func bindData() {
        viewModel.resultLabel.bind { result in
            self.resultLabel.text = result
        }
    }
    
    
    func configViews() {
        view.backgroundColor = .black
        
        let textfields = [emailPhoneTextField, passwordTextField, nicknameTextField, locationTextField, promotionCodeTextField]
        for textfield in textfields {
            textfield.delegate = self
        }
        let stackView = UIStackView(arrangedSubviews: textfields)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        
        let components = [nameLabel, stackView, signUpButton, extraInfoLabel, redSwitch, resultLabel]
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
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(extraInfoLabel.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(stackView.snp.horizontalEdges)
            make.height.equalTo(40)
        }
    }
    
}

//MARK: - Extension for TextField Delegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        //update data
        viewModel.emailText = emailPhoneTextField.text
        viewModel.pwText = passwordTextField.text
        viewModel.nicknameText = nicknameTextField.text
        viewModel.locationText = locationTextField.text
        viewModel.promoNum = promotionCodeTextField.text
        
        if viewModel.checkValidation() {
            signUpButton.backgroundColor = .cyan
            signUpButton.isEnabled = true
        } else {
            signUpButton.backgroundColor = .lightGray
            signUpButton.isEnabled = false
        }
        
        return true
    }
    
}
