//
//  RealmCollectionViewController.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/14.
//

import UIKit
import SnapKit
import RealmSwift

class RealmCollectionViewController: BaseViewController {
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return view
    }()
    
    //realm에서 가져올 table
    var list: Results<TodoTable>!
    
    
    //List Cell: system 형식의 cell 활용
    //data type: Realm에서 가져오고 저장할 data type으로
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, TodoTable>!
    
    
    //realm 경로 호출용
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //Realm에서 데이터 가져오기
        list = realm.objects(TodoTable.self)
        
        
        
        //cellRegistration 초기화
        //itemIdentifier = list[indexPath.item]
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.image = itemIdentifier.favorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            content.text = itemIdentifier.title
            content.secondaryText = "\(itemIdentifier.detail.count)개의 세부 할 일"
            
            cell.contentConfiguration = content
        })
        
        
        
    }
    
    override func configure() {
        super.configure()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    
    static func createCompositionalLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    
}

//MARK: - Extension for CollectionView Delegate, DataSource

extension RealmCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //item: 실질적 data
        //Registration의 타입으로 제약 설정
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        return cell
    }
    
}
