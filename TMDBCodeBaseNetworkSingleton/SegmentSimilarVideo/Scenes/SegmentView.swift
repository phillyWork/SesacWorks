//
//  SegmentView.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SegmentView: BaseView {
    
    let segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["First", "Second"])

        //segment instance 생성 ~ 에러 나타나면 왜 나타나는지 확인할 수 있으면 Okay
//        let control = UISegmentedControl()
        control.selectedSegmentIndex = 0
        control.setTitle("비슷한 컨텐츠", forSegmentAt: 0)
        control.setTitle("youtube", forSegmentAt: 1)
        return control
    }()

    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout())
        view.register(SimilarMediaCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMediaCollectionViewCell.identifier)
        view.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        return view
    }()
    
    override func configViews() {
        super.configViews()
        addSubview(segmentControl)
        addSubview(collectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        segmentControl.snp.makeConstraints { make in
            make.centerX.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(15)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
//            make.height.equalTo(self.safeAreaLayoutGuide).multipliedBy(0.75)
            make.top.equalTo(segmentControl.snp.bottom).offset(10)
        }
        
    }
    
    func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.scrollDirection = .vertical
        
        let spacing: CGFloat = 8
        
        let width = UIScreen.main.bounds.width - spacing * 2
        
        flowLayout.itemSize = CGSize(width: width, height: width * 0.5)
        flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        
        return flowLayout
    }
    
}
