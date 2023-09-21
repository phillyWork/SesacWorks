//
//  CollectionCompositionalViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/21.
//

import UIKit
import SnapKit

class CollectionCompositionalViewController: UIViewController {
    
    //MARK: - Properties
    
    let list = Array(0...100)
    
    //frame zero: 크기 설정하지 않음 --> layout으로 이후에 잡기
    //collectionViewLayout: cell 크기 설정
    
    //instance property에 instance method 결과값 활용: instance 생성 이후 사용 가능
    //해결: lazy var instance로 구성 (collectionView가 method 이후 생성되도록)
    //다른 해결: static method로 활용 (type method가 instance와 상관 없음, data 영역 위치 (VC deinit 되어도 앱이 꺼질 때까지 위치)
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionFlowLayout())

    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        configureHierarchy()
        configureLayout()
        
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureCollectionFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        return layout
    }
    
    
    func configureDataSource() {
        
    }
    
    
    
}

//MARK: - Extension for CollectionView Delegate, DataSource

extension CollectionCompositionalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
        cell.label.text = "\(list[indexPath.item])번째"
        return cell
    }
    
    
    
    
    
}
