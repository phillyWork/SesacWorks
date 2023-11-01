//
//  SearchCell.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/21.
//

import UIKit
import SnapKit

class SearchCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    //codebase 실행 시 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    //storyboard 실행 시 초기화
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure() {
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        label.text = "테스트"
        label.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
