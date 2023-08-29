//
//  SegmentView.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SegmentView: BaseView {
    
    let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl()
        control.selectedSegmentIndex = 0
        control.setTitle("비슷한 영화들", forSegmentAt: 0)
        control.setTitle("video", forSegmentAt: 1)
        return control
    }()

    let collectionView: UICollectionView = {
        let view = UICollectionView()
        view.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: SegmentCollectionViewCell.identifier)
        return view
    }()
    
}
