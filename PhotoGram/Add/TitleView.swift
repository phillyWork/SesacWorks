//
//  TitleView.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class TitleView: BaseView {
    
    let textField = {
        let tf = UITextField()
        tf.placeholder = "제목을 입력해주세요"
        return tf
    }()
    
    override func configViews() {
        super.configViews()
        
        addSubview(textField)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(50)
        }
    }
    
}

