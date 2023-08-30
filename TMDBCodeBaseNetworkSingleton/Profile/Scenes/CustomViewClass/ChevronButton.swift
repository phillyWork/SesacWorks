//
//  ChevronButton.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class ChevronButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configButton() {
        setImage(UIImage(systemName: "chevron.right"), for: .normal)
        tintColor = .green
        backgroundColor = .yellow
    }
    
}
