//
//  ViewController.swift
//  CollectionViewCompositionalLayoutDiffableDataSource
//
//  Created by Heedon on 2023/09/15.
//

import UIKit
import SnapKit

class SettingsViewController: UIViewController {

    //MARK: - Properties

    let settingData = [Sample(title: EachCase.focus.title, systemImageString: EachCase.focus.imageString), Sample(title: EachCase.sleep.title, systemImageString: EachCase.sleep.imageString), Sample(title: EachCase.workTime.title, systemImageString: EachCase.workTime.imageString), Sample(title: EachCase.privateTime.title, systemImageString: EachCase.privateTime.imageString)]
    
    let switchData = [Sample(title: "모든 기기에서 공유", systemImageString: nil)]
    
    private var diffableDataSource: UICollectionViewDiffableDataSource<Int, Sample>!
    
    lazy private var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        return view
    }()
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        setupCollectionViewCell()
        
        var snapshot = NSDiffableDataSourceSnapshot<Int, Sample>()
        
        snapshot.appendSections([1, 2])
        snapshot.appendItems(settingData, toSection: 1)
        snapshot.appendItems(switchData, toSection: 2)
        
        diffableDataSource.apply(snapshot)
    }

    private func setupCollectionViewCell() {
        //Cell Registration
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Sample> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.title
            
            if let imageString = itemIdentifier.systemImageString {
                content.image = UIImage(systemName: imageString)
            }
            
            cell.contentConfiguration = content
        }
        
        //Diffable DataSource
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            return cell
        })
    
    }
    
    private func createCompositionalLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
}
