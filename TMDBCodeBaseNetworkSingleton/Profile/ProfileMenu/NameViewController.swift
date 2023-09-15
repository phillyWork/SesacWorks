//
//  NameViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

//closure
class NameViewController: BaseViewController {
    
    var name: String?
    
    var completionHandler: ((String) -> ())?
    
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
        textField.delegate = self
        
        guard let name = name else { return }
        textField.text = name
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    @objc func saveDataButtonTapped() {
        
        if let text = textField.text {
            completionHandler?(text)
        }
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - Extension for TextField Delegate

extension NameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

