//
//  SearchCollectionViewCell.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    let imageView = {
        let iv = UIImageView()
        iv.backgroundColor = .lightGray
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    //BaseCell에서 init 이미 설정해놓음 (원래대로면 init과 required 작성했어야 함)
    //override만 작성하면 됨
    
    //tableCell, collectionCell: contentView 가지고 활용
    
    override func configViews() {
        contentView.addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
}
