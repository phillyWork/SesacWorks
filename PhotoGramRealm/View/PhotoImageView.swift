//
//  PhotoImageView.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit

//더 이상 상속 X / 재정의 X
//static dispatch 방식으로 동작하도록 알림
//원래: class --> 상속으로 인해 runtime때 어떤 함수가 실행될지 결정됨 (override, super 호출...)
//compile time때 동작하도록 함
final class PhotoImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = Constants.Desgin.cornerRadius
        layer.borderWidth = Constants.Desgin.borderWidth
        layer.borderColor = Constants.BaseColor.border
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
