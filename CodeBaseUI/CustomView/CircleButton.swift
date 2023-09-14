//
//  CircleButton.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit

class CircleButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configCircleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCircleButton() {
        layer.borderColor = UIColor.systemBrown.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
    }
    
}
