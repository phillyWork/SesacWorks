//
//  AgeViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class AgeViewController: BaseViewController {
    
    var age: Int?
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .darkGray
        tf.textColor = .white
        tf.font = .boldSystemFont(ofSize: 15)
        return tf
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveDataButtonTapped))
        
        view.addSubview(textField)
        
        guard let age = age else { return }
        textField.text = "\(age)"
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func saveDataButtonTapped() {
        
        
        
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Extension for TextField Delegate

extension AgeViewController: UITextFieldDelegate {
    
    
    
}

