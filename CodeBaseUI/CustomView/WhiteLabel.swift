//
//  WhiteLabel.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit

class WhiteLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLabel() {
        textColor = .white
        backgroundColor = .red
    }
    
    func setText(text: String, font: TextFontType, size: CGFloat) {
        self.text = text
        switch font {
        case .bold:
            self.font = UIFont.boldSystemFont(ofSize: size)
        case .medium:
            self.font = UIFont.systemFont(ofSize: size, weight: .medium)
        case .light:
            self.font = UIFont.systemFont(ofSize: size, weight: .light)
        }
    }
}
