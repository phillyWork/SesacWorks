//
//  BaseCollectionViewCell.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit
import SnapKit

//tableViewCell 및 다른 UI Class도 BaseView 설정 후, custom class 만들어서 상속하기
class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViews() {
        
    }
    
    func setConstraints() {
        
    }
    
}
