//
//  ViewController.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import UIKit

class ViewController: UIViewController {

    let dataManager = DataManager.shared
    
    //원피스: 37854
    //블랙 미러
    let seriesId = 42009
    
    var count = 0
    
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var tvCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configCollectionView()
        
        configSeasonWithEpisodeDetail()
    }
    
    
    //개선 필요: 매 season마다 일일히 가져와야 하는건지, 언제 collectionview를 config하고 reload할 지
    //--> dispatchgroup 활용: 의문 --> 왜 fetchepisodelist에선 leave 메서드가 작동하지 않는 것인지
    func configSeasonWithEpisodeDetail() {
        dataManager.fetchSeasonList(type: .seasonDetail, seriesId: seriesId) {
            
            for season in self.dataManager.getSeasonList() {
                self.dispatchGroup.enter()
                self.count += 1
                print("Increment Count: \(self.count)")
                print("Enter Works")
                self.dataManager.fetchEpisodeList(type: .episodeDetail, seriesId: self.seriesId, seasonNumber: season.seasonNumber) {
                    
                    print("Season \(season.seasonNumber): \(self.dataManager.getEpisodeList(seasonNumber: season.seasonNumber))")
                    print("Waiting to be done on fetchEpisodeList inside for loop")

                    self.dispatchGroup.leave()
                    self.count -= 1
                    print("Decrement Count: \(self.count)")
                    print("Leave Works for sure")
                }
//                self.dispatchGroup.wait()
//                print("Waiting to be done on fetchEpisodeList")
//                self.dispatchGroup.leave()
                print("Leave Works Out of concurrent")
            }
            print("Count out of for loop: \(self.count)")
//            self.dispatchGroup.wait()
            self.dispatchGroup.notify(queue: .main) {
                print("Count for notify: \(self.count)")
                print("All Concurrent works are done!!!")
//                self.configCollectionView()
                self.tvCollectionView.reloadData()
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
        flowLayout.headerReferenceSize = CGSize(width: width, height: width * 0.5)
        
        tvCollectionView.collectionViewLayout = flowLayout
    }


}

//MARK: - Extension for CollectionView Delegate, DataSource

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        print("section number: \(dataManager.getSeasonList().count)")
        return dataManager.getSeasonList().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(#function)
        let season = dataManager.getSeasonList()[section]
        guard let episodeList = dataManager.getEpisodeList(seasonNumber: season.seasonNumber) else {
            print("No data to show on collectionView")
            return 0
        }
    
        print("episode count for season \(season.seasonNumber): \(episodeList.count)")
//        return season.episodeCount
        return episodeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = tvCollectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath) as? EpisodeCollectionViewCell else {
            return UICollectionViewCell()
        }

//        let season = dataManager.getSeasonList()[indexPath.row]
//        print("season name: \(season.name) and season number: \(season.seasonNumber)")
        
//        print("season number in cellForItem: \(dataManager.getSeasonList()[indexPath.section].seasonNumber)")
        if let episodeList = dataManager.getEpisodeList(seasonNumber: dataManager.getSeasonList()[indexPath.section].seasonNumber) {
            cell.episode = episodeList[indexPath.item]
            print("episode name: ", episodeList[indexPath.item].name)
        }
        return cell
    }
    
    
    //for reusable view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = tvCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SeasonCollectionReusableView.identifier, for: indexPath) as? SeasonCollectionReusableView else {
                return UICollectionReusableView()
            }
            
            view.season = dataManager.getSeasonList()[indexPath.section]
            print("season name: ", dataManager.getSeasonList()[indexPath.section].name)
            return view
        } else {
            return UICollectionReusableView()
        }
    }
    
}
