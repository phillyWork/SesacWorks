//
//  SecondViewController.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/22.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    //MARK: - Properties
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .darkGray
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .line
        tf.placeholder = "제목을 입력해주세요"
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 14, weight: .medium)
        return tf
    }()
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .line
        tf.placeholder = "날짜를 입력해주세요"
        tf.textAlignment = .center
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.borderWidth = 1
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 14, weight: .medium)
        return tf
    }()
    
    let inputTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderColor = UIColor.black.cgColor
        tv.layer.borderWidth = 1
        tv.isEditable = true
        tv.font = .systemFont(ofSize: 12, weight: .light)
        
        return tv
    }()
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let components = [imageView, titleTextField, dateTextField, inputTextView]
        for item in components {
            view.addSubview(item)
        }
        
        configConstraints()
    }
    
    func configConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(imageView.snp.width).multipliedBy(0.8)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(imageView.snp.horizontalEdges)
            make.height.equalTo(35)
        }
        
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).offset(15)
            make.horizontalEdges.equalTo(imageView.snp.horizontalEdges)
            make.height.equalTo(titleTextField)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(imageView.snp.horizontalEdges)
        }
        
    }
    


}
