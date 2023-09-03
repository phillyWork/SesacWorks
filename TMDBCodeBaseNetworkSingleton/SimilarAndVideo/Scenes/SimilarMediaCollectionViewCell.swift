//
//  SegmentCollectionViewCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

import UIKit

class SimilarMediaCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    var media: Similar? {
        didSet {
            updateWithData()
        }
    }
    
    let coverImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel = {
        let label = UILabel()
        
        return label
    }()
    
    let dateRateLabel = {
        let label = UILabel()
        
        return label
    }()
    
    let overviewLabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    //MARK: - Setup
    
    override func configViews() {
        super.configViews()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    private func updateWithData() {
        
    }
    
}
