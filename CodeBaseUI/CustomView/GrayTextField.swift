//
//  GrayTextField.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit

class GrayTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configTextField() {
        textColor = .white
        textAlignment = .center
        backgroundColor = .lightGray
        clipsToBounds = true
        layer.cornerRadius = 5
        font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    func setPlaceholderColor(text: String) {
        attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
}
