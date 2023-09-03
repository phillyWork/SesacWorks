//
//  TrendView.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class TrendView: BaseView {
    
    lazy var collectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout())
        collection.register(TrendCollectionViewCell.self, forCellWithReuseIdentifier: TrendCollectionViewCell.identifier)
        return collection
    }()
 
    override func configViews() {
        super.configViews()
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - 2 * spacing
        
        layout.itemSize = CGSize(width: width, height: width * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        return layout
    }
    
}
