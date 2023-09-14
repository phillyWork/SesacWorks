//
//  BaseView.swift
//  TMDBTrendingAllMultipleCellInTableViewCell
//
//  Created by Heedon on 2023/09/03.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViews() {
        self.backgroundColor = .systemPink
    }
    
    func setConstraints() {
        
    }
    
}
