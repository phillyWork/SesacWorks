//
//  SubTitleView.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class SubTitleView: BaseView {
    
    let textView = {
        let tv = UITextView()
        tv.backgroundColor = .lightGray
        return tv
    }()
    
    override func configViews() {
        super.configViews()
        
        addSubview(textView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        textView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(250)
        }
    }
    
}
