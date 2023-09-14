//
//  SimpleCollectionViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/14.
//

import UIKit
import SnapKit

class SimpleCollectionViewController: UIViewController {
    
    private var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]
    
    //instance 생성 시에 layout 설정 필요
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    //CellRegistration 등록용
    //어떤 type의 cell 활용, 어떤 type의 data 활용 정의
    //ListCell: iOS 14 이상, system cell 설정
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    
        
        //UICollectionView.CellRegistration
        //iOS 14 이상
        //method 대신 Generic 활용: dequeueConfiguredReusableCell 메서드에서 cell이 생성될 때마다 closure 호출
        //cell UI 구성 및 data 처리 정의
        cellRegistration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            //cell: UI 구성
            //itemIdentifier: cell당 보여줄 data
            
            //미리 design되어 있는 system cell 가지고 와서 활용 (list cell 활용)
            var content = UIListContentConfiguration.valueCell()
//            var content = UIListContentConfiguration.subtitleCell()
//            var content = UIListContentConfiguration.sidebarCell()
            
            //내부 property에 data 할당
            content.text = itemIdentifier.name
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            
            //UI 설정: Properties 접근
            content.textProperties.alignment = .center
            content.textProperties.color = .orange
            content.secondaryTextProperties.color = .yellow
            content.imageProperties.tintColor = .green
            
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            
            cell.contentConfiguration = content
            
            
            //background 설정 (cell 전체적인 background 설정)
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .purple
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 5
            backgroundConfig.strokeColor = .blue
            
            cell.backgroundConfiguration = backgroundConfig
            
            
        })
        
        
        

        
    }
    
    //FlowLayout 쓰지 않는 방향
    //system style 기반 구성 --> List Configuration 활용
    
    //instance 생성보다 먼저 이뤄저야 하므로, static 설정
    //or collectionView를 lazy로 선언
    static func createLayout() -> UICollectionViewLayout {
        
        //전체 collectionView 설정
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)      //apperance ~ sidebar: iPad 활용 다수
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemPink
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
//        collectionView.collectionViewLayout = layout
        return layout
    }
    
    
}

//MARK: - Extension for CollectionView Delegate, DataSource


extension SimpleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        //재사용 cell 만드는 다른 방법
        //CellRegistration: cell UI 설정 및 data 구성 처리 ~ 등록만 처리
        //item: data 들어갈 자리
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.item])
        return cell
    }
    
}
