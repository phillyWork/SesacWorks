//
//  DarkTextField.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class DarkTextLabelWhiteText: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configLabel() {
        backgroundColor = .darkGray
        textColor = .white
        font = .boldSystemFont(ofSize: 15)
        textAlignment = .center
    }
}
