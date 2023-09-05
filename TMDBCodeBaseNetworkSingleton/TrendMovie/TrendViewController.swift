//
//  ViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class TrendViewController: BaseViewController {

    var trendType = TrendData.trendAll
    let dataManager = DataManager.shared
    let trendView = TrendView()
    
    override func loadView() {
        self.view = trendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialMovie()
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "All", style: .plain, target: self, action: #selector(trendButtonTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profileButtonTapped))
        
        trendView.collectionView.delegate = self
        trendView.collectionView.dataSource = self
        trendView.collectionView.prefetchDataSource = self
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    func setupInitialMovie() {
        dataManager.setupAllTrendList(type: .trendAll, page: dataManager.getPageNumForTrend()) {
            print("Setup data done")
            self.trendView.collectionView.reloadData()
        }
    }
    
    //MARK: - Handlers
    
    @objc func profileButtonTapped() {
        let profileVC = ProfileViewController()
        profileVC.profile = dataManager.getProfile()
        let nav = UINavigationController(rootViewController: profileVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
    @objc func trendButtonTapped() {
        //All --> Movie --> TV --> ALL...
        switch trendType {
        case .trendAll:
            trendType = .trendMovie
            navigationItem.leftBarButtonItem?.title = "Movie"
        case .trendMovie:
            trendType = .trendTV
            navigationItem.leftBarButtonItem?.title = "TV"
        case .trendTV:
            trendType = .trendAll
            navigationItem.leftBarButtonItem?.title = "All"
        }
        trendView.collectionView.reloadData()
    }
    
}

//MARK: - Extension for CollectionView Delegate and DataSource

extension TrendViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch trendType {
        case .trendAll:
            return dataManager.getAllTrend().count
        case .trendMovie:
            return dataManager.getMovieTrend().count
        case .trendTV:
            return dataManager.getTVTrend().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendView.collectionView.dequeueReusableCell(withReuseIdentifier: TrendCollectionViewCell.identifier, for: indexPath) as? TrendCollectionViewCell else { return UICollectionViewCell() }
            
        switch trendType {
        case .trendAll:
            cell.trendMedia = dataManager.getAllTrend()[indexPath.item]
        case .trendMovie:
            cell.trendMedia = dataManager.getMovieTrend()[indexPath.item]
        case .trendTV:
            cell.trendMedia = dataManager.getTVTrend()[indexPath.item]
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let castVC = CastViewController()
//        let segmentVC = SegmentControlViewController()
        
        switch trendType {
        case .trendAll:
            castVC.trendMedia = dataManager.getAllTrend()[indexPath.item]
//            segmentVC.media = dataManager.getAllTrend()[indexPath.item]
        case .trendMovie:
            castVC.trendMedia = dataManager.getMovieTrend()[indexPath.item]
//            segmentVC.media = dataManager.getMovieTrend()[indexPath.item]

        case .trendTV:
            castVC.trendMedia = dataManager.getTVTrend()[indexPath.item]
//            segmentVC.media = dataManager.getTVTrend()[indexPath.item]
        }
        
        navigationController?.pushViewController(castVC, animated: true)
//        navigationController?.pushViewController(segmentVC, animated: true)

    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            switch trendType {
            case .trendAll:
                if dataManager.getAllTrend().count - 1 == indexPath.item {
                    dataManager.addTrendPageNum()
                    dataManager.setupAllTrendList(type: .trendAll, page: dataManager.getPageNumForTrend()) {
                        self.trendView.collectionView.reloadData()
                    }
                }
            case .trendMovie:
                if dataManager.getMovieTrend().count - 1 == indexPath.item {
                    dataManager.addTrendPageNum()
                    dataManager.setupAllTrendList(type: .trendAll, page: dataManager.getPageNumForTrend()) {
                        self.trendView.collectionView.reloadData()
                    }
                }
            case .trendTV:
                if dataManager.getTVTrend().count - 1 == indexPath.item {
                    dataManager.addTrendPageNum()
                    dataManager.setupAllTrendList(type: .trendAll, page: dataManager.getPageNumForTrend()) {
                        self.trendView.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//
//    }
    
}
