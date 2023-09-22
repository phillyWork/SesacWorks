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
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionCompositionalLayout())

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
    
    
    //compositionalLayout으로 구성하기: cell size가 유동적 / 수평 scroll 다 다르게 & section 별 다른 구성
    //layout에서 시작, 역으로 instance 하나씩 구성해나가는 과정
    func configureCollectionCompositionalLayout() -> UICollectionViewLayout {
       
        //layoutSize
        //item이 속한 container: group --> group width의 1/3을 차지 의미
        //height: group과 동일한 height 가지기 --> 1.0 비율 적용
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1.0))
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/4), heightDimension: .fractionalHeight(1.0))
        
        //layoutItem
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        //layoutSize
        //absolute: 고정값 적용
        //fractionalWidth, 비율 1.0 --> 속한 container와의 비율 적용
        //group: section에 속하기에 1.0: 디바이스 너비와 동일해짐
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
 
        //layoutGroup
        //repeatingSubitem: 반복할 item
        //count: 반복 횟수
        
        //AppStore 구성: group in vertical

//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
        
        //group count 맞게 item size 다시 계산 (WWDC2019) --> deprecated
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: <#T##NSCollectionLayoutSize#>, subitem: <#T##NSCollectionLayoutItem#>, count: <#T##Int#>)
        
        //group 내 간격 생성
        group.interItemSpacing = .fixed(10)
        
        
        //Section을 instance로 보유
        let section = NSCollectionLayoutSection(group: group)
        
        //group 간 간격 생성
        section.interGroupSpacing = 40
        
        //item 어디서부터 둘 것인지 설정: inset 구성
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        //CollectionViewLayout protocol 채택
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        //여러 section 구성 가능
        //코드 추가 필요
        
        return layout
    }

    //간단한 UI 구성 (단순 n * n 구성)
    func configureCollectionFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
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
