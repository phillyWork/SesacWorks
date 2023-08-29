//
//  SegmentControlViewController.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SegmentControlViewController: BaseViewController {

    let dataManager = DataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSimilarAndVideoLists()
    }
    
    private func setupSimilarAndVideoLists() {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        dataManager.setupSimilarMovieList(type: .similarMovie, movieId: dataManager.getMovieID(), pageNum: dataManager.getPageNumForSimilar()) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dataManager.setupVideoList(type: .video, movieId: dataManager.getMovieID()) {
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            <#code#>
        }
    }
    
    override func configViews() {
        super.configViews()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    
    

}
