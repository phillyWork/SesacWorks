//
//  AppSettingsViewController.swift
//  CollectionViewCompositionalLayoutDiffableDataSource
//
//  Created by Heedon on 2023/09/15.
//

import UIKit
import SnapKit

class AppSettingsViewController: UIViewController {
    
    //MARK: - Enum
    enum Settings: CaseIterable {
        case wholeSetting
        case privateSetting
        case otherSetting
    }
    
    //MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return view
    }()
    
    var diffableDataSource: UICollectionViewDiffableDataSource<Settings, String>!
    
    let wholeSetting = ["공지사항", "실험실", "버전 정보"]
    let privateSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let otherSetting = ["고객센터/도움말"]
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupCollectionView()
        
        var snapshot = NSDiffableDataSourceSnapshot<Settings, String>()
        snapshot.appendSections(Settings.allCases)
        snapshot.appendItems(wholeSetting, toSection: Settings.wholeSetting)
        snapshot.appendItems(privateSetting, toSection: Settings.privateSetting)
        snapshot.appendItems(otherSetting, toSection: Settings.otherSetting)
        
        diffableDataSource.apply(snapshot)
    }
    
    private func setupCollectionView() {
        //Cell Registration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.cell()
            content.text = itemIdentifier
            content.textProperties.font = .systemFont(ofSize: 13, weight: .medium)
            cell.contentConfiguration = content
        }
        
        //Diffable DataSource
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
        //for headerView
//        diffableDataSource.supplementaryViewProvider = {
//
//        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .grouped)
//        config.headerMode = .supplementary
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
}
