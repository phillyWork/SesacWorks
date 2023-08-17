//
//  ViewController.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import UIKit

class ViewController: UIViewController {

    let dataManager = DataManager.shared
    
    let seriesId = 37854 //애니메이션 원피스
    
    @IBOutlet weak var tvCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configSeasonWithEpisodeDetail {
            self.configCollectionView()
        }
    }
    
    
    //개선 필요: 매 season마다 일일히 가져와야 하는건지, 언제 collectionview를 config하고 reload할 지
    func configSeasonWithEpisodeDetail(completionHandler: @escaping () -> ()) {
        dataManager.fetchSeasonList(type: .seasonDetail, seriesId: seriesId) {
            for season in self.dataManager.getSeasonList() {
                DispatchQueue.global().async {
                    self.dataManager.fetchEpisodeList(type: .episodeDetail, seriesId: self.seriesId, seasonNumber: season.seasonNumber) {
                        print("Season \(season.seasonNumber): \(self.dataManager.getEpisodeList(seasonNumber: season.seasonNumber))")
                    }
                }
            }
            DispatchQueue.main.async {
                completionHandler()
            }
        }
    }
    
    func configCollectionView() {
        print(#function)
        tvCollectionView.register(UINib(nibName: EpisodeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        tvCollectionView.register(UINib(nibName: SeasonCollectionReusableView.identifier, bundle: nil) , forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SeasonCollectionReusableView.identifier)
        
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
        
        configCollectionViewFlowLayout()
    }
    
    func configCollectionViewFlowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let spacing: CGFloat = 8
        let cellWidth = UIScreen.main.bounds.width - 2*spacing
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.7)
        flowLayout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        flowLayout.minimumLineSpacing = spacing
        flowLayout.minimumInteritemSpacing = spacing
        
        let width = UIScreen.main.bounds.width
        flowLayout.headerReferenceSize = CGSize(width: width, height: width * 0.3)
        
        tvCollectionView.collectionViewLayout = flowLayout
    }


}

//MARK: - Extension for CollectionView Delegate, DataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataManager.getSeasonList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        let season = dataManager.getSeasonList()[section]
        return season.episodeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        let season = dataManager.getSeasonList()[indexPath.row]
//        print("season name: \(season.name) and season number: \(season.seasonNumber)")
        
        print("season number in cellForItem: \(dataManager.getSeasonList()[indexPath.section].seasonNumber)")
        if let episodeList = dataManager.getEpisodeList(seasonNumber: dataManager.getSeasonList()[indexPath.section].seasonNumber) {
            cell.episode = episodeList[indexPath.row]
            print("episode name: ", episodeList[indexPath.row].name)
        }
        return cell
    }
    
    
    //for reusable view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = tvCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeasonCollectionReusableView.identifier, for: indexPath) as? SeasonCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.season = dataManager.getSeasonList()[indexPath.row]
            print("season name: ", dataManager.getSeasonList()[indexPath.row].name)
            return view
        } else {
            return UICollectionReusableView()
        }
    }
    
}
