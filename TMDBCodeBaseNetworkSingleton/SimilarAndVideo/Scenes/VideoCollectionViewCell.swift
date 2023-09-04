//
//  VideoCollectionViewCell.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/09/04.
//

import UIKit

class VideoCollectionViewCell: BaseCollectionViewCell {
    
    //MARK: - Properties
    
    var video: Video? {
        didSet {
            updateWithData()
        }
    }
    
    override func configViews() {
        super.configViews()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    private func updateWithData() {
        
    }
    
}
