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

    //Diffable DataSource 활용
    //generic: section data type, cell data type
    
    //DiffableDataSource: class
    //상속받는 class를 따로 만들어서 Diffable이 처리하는 것으로 분리 가능
    var diffableDataSource: UICollectionViewDiffableDataSource<Int, Int>!
    
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
        configureHierarchy()
        configureLayout()
        
        //Diffable 활용: CellReigstration으로 처리
//        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: "cell")
        
        configureDataSource()
        
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        
        //Diffable 활용: 필요없음
//        collectionView.delegate = self
//        collectionView.dataSource = self
        
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
        
        //cell 등록해서 SearchCell 활용할 것 설정
        //generic: cell type, data type 정의
        let cellRegistration = UICollectionView.CellRegistration<SearchCell, Int> { cell, indexPath, itemIdentifier in
            //cell 내부의 component 설정
            cell.imageView.backgroundColor = .orange
            cell.imageView.image = UIImage(systemName: "star")
            cell.label.text = "\(self.list[indexPath.item])번째"
        }
        
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            //재사용: dataSource 기반 설정
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
        
        //snapshot 준비: dataSource와 동일 타입
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        snapshot.appendSections([0])        //section을 indexPath로 관리하지 않음, 설정 type대로 관리
        snapshot.appendItems(list)
        
        //snapshot 찍기
        diffableDataSource.apply(snapshot)
        
    }
    
}


//Diffable 활용: protocol 활용하지 않음
//내부 함수: 직접 만든 함수처럼 활용

//Diffable로 대체: 활용하지 않음

//extension CollectionCompositionalViewController {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
//        cell.label.text = "\(list[indexPath.item])번째"
//        return cell
//    }
//
//}



//MARK: - Extension for CollectionView Delegate, DataSource

//extension CollectionCompositionalViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCell
//        cell.label.text = "\(list[indexPath.item])번째"
//        return cell
//    }
//
//}
