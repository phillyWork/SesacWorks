//
//  WhiteImageButton.swift
//  CodeBaseUI
//
//  Created by Heedon on 2023/08/24.
//

import UIKit

class WhiteImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configButton() {
        tintColor = .white
        backgroundColor = .systemGreen
    }
    
    func setupTitleAndImageTogether(type: TextFontType, size: CGFloat, title: String, imageName: String) {
        var configuration = UIButton.Configuration.plain()
        var attributeContainer = AttributeContainer()
        switch type {
        case .bold:
            attributeContainer.font = UIFont.boldSystemFont(ofSize: size)
        case .medium:
            attributeContainer.font = UIFont.systemFont(ofSize: size, weight: .medium)
        case .light:
            attributeContainer.font = UIFont.systemFont(ofSize: size, weight: .light)
        }
        configuration.attributedTitle = AttributedString(title, attributes: attributeContainer)
        configuration.image = UIImage(named: imageName)
        configuration.imagePlacement = .top
        self.configuration = configuration
    }
    
    
}
