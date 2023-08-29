//
//  ViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class TrendMovieViewController: BaseViewController {

    let dataManager = DataManager.shared
    let trendView = TrendMovieView()
    
    override func loadView() {
        self.view = trendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialMovie()
    }
    
    override func configViews() {
        super.configViews()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: self, action: #selector(profileButtonTapped))
        
        trendView.collectionView.delegate = self
        trendView.collectionView.dataSource = self
        trendView.collectionView.prefetchDataSource = self
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    func setupInitialMovie() {
        dataManager.setupMovieTrendList(type: .trendMovie, page: 1) {
            print("Setup Data is done")
            self.trendView.collectionView.reloadData()
        }
    }
    
    @objc func profileButtonTapped() {
        let profileVC = ProfileViewController()
        profileVC.profile = dataManager.getProfile()
        let nav = UINavigationController(rootViewController: profileVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}

//MARK: - Extension for CollectionView Delegate and DataSource

extension TrendMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataManager.getMovieTrend().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = trendView.collectionView.dequeueReusableCell(withReuseIdentifier: TrendMovieCollectionViewCell.identifier, for: indexPath) as? TrendMovieCollectionViewCell else { return UICollectionViewCell() }
        
        cell.movie = dataManager.getMovieTrend()[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let castVC = CastViewController()
        castVC.movie = dataManager.getMovieTrend()[indexPath.item]
        navigationController?.pushViewController(castVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if dataManager.getMovieTrend().count - 1 == indexPath.row {
                dataManager.addPageNum()
                dataManager.setupMovieTrendList(type: .trendMovie, page: dataManager.getPageNumForTrend()) {
                    self.trendView.collectionView.reloadData()
                }
            }
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//
//    }
    
}
