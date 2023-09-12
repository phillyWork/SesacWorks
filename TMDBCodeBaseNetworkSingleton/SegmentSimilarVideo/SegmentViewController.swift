//
//  SegmentViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/09/05.
//

import UIKit

class SegmentViewController: BaseViewController {

    let dataManager = DataManager.shared

    let segmentView = SegmentView()
    
    var media: Trend?
    
    override func loadView() {
        self.view = segmentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configViews() {
        super.configViews()
        
        segmentView.collectionView.delegate = self
        segmentView.collectionView.dataSource = self
        segmentView.collectionView.prefetchDataSource = self
        
        segmentView.segmentControl.addTarget(self, action: #selector(segmentTapped), for: .valueChanged)
        
        setupSimilarAndVideoLists()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }

    private func setupSimilarAndVideoLists() {
        guard let media = media else { return }
        
        let dispatchGroup = DispatchGroup()
        
        switch media.mediaType {
        case .movie:
            dispatchGroup.enter()
            dataManager.setupSimilarList(type: .similarMovie, movieId: media.id, seriesId: nil, pageNum: dataManager.getPageNumForSimilar()) {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            dataManager.setupVideoList(type: .videoMovie, movieId: media.id, seriesId: nil) {
                dispatchGroup.leave()
            }
        case .tv:
            dispatchGroup.enter()
            dataManager.setupSimilarList(type: .similarTV, movieId: nil, seriesId: media.id, pageNum: dataManager.getPageNumForSimilar()) {
                dispatchGroup.leave()
            }
            dispatchGroup.enter()
            dataManager.setupVideoList(type: .videoTV, movieId: nil, seriesId: media.id) {
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            print("Done!")
            self.segmentView.collectionView.reloadData()
        }
    }
    
    @objc func segmentTapped() {
        segmentView.collectionView.reloadData()
    }
    
}

//MARK: - Extension for CollectionView Delegate, DataSource, PrefetchDataSource

extension SegmentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch segmentView.segmentControl.selectedSegmentIndex {
        case 0: return dataManager.getSimilarList().count
        case 1: return dataManager.getVideoList().count
        default: return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch segmentView.segmentControl.selectedSegmentIndex {
        case 0:
            guard let cell = segmentView.collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMediaCollectionViewCell.identifier, for: indexPath) as? SimilarMediaCollectionViewCell else { return UICollectionViewCell() }
            cell.media = dataManager.getSimilarList()[indexPath.item]
            return cell
        case 1:
            guard let cell = segmentView.collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
            cell.video = dataManager.getVideoList()[indexPath.item]
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentView.segmentControl.selectedSegmentIndex == 1 {
            let webVC = WebViewController()
            webVC.video = dataManager.getVideoList()[indexPath.item]
            let nav = UINavigationController(rootViewController: webVC)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if segmentView.segmentControl.selectedSegmentIndex == 0 {
            for indexPath in indexPaths {
                if dataManager.getSimilarList().count - 1 == indexPath.item {
                    dataManager.addSimilarPageNum()
                    switch media?.mediaType {
                    case .movie:
                        dataManager.setupSimilarList(type: .similarMovie, movieId: media?.id, seriesId: nil, pageNum: dataManager.getPageNumForSimilar()) {
                            self.segmentView.collectionView.reloadData()
                        }
                    case .tv:
                        dataManager.setupSimilarList(type: .similarTV, movieId: nil, seriesId: media?.id, pageNum: dataManager.getPageNumForSimilar()) {
                            self.segmentView.collectionView.reloadData()
                        }
                    default:
                        break
                    }
                }
            }
        }
    }
    
}
