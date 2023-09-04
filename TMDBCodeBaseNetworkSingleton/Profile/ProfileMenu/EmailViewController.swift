//
//  EmailViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

//Notification
class EmailViewController: BaseViewController {
    
    var email: String?
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .darkGray
        tf.textColor = .white
        tf.font = .boldSystemFont(ofSize: 15)
        return tf
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let email = email else { return }
        textField.text = email
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveDataButtonTapped))
        
        view.addSubview(textField)
        
        textField.delegate = self
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func saveDataButtonTapped() {
        print(#function)
        guard let text = textField.text else {
            print("No Input!")
            return
        }
        
        NotificationCenter.default.post(name: .userEmail , object: nil, userInfo: ["newEmail": text])
        
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extension for TextField Delegate

extension EmailViewController: UITextFieldDelegate {
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


