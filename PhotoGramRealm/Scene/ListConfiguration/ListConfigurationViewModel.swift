//
//  ListConfigurationViewModel.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/14.
//

import UIKit

class ListConfigurationViewModel {
    
    private let realmManager = ListConfigRealmManager()
    private let networkManager = ListConfigurationNetworkManager()
    
    var photoResults: ListConfigurationObservable<[PhotoResult]?> = ListConfigurationObservable(nil)
    
    var searchQuery: ListConfigurationObservable<String> = ListConfigurationObservable("")
    
    var imageLists = [UIImage]()
    
    func callRequest(query: String) {
        networkManager.searchPhoto(query: query) { data in
            guard let data = data else { return }
            print("Getting data from API succeed!")
            self.photoResults.value = data.results
        }
    }
    
    func getImageFromNetwork(url: String, completionHandler: @escaping (UIImage) -> ()) {
        networkManager.getImageFromNetwork(url: url) { image in
            print("Getting image succeed in \(Thread.current)")
            completionHandler(image)
        }
    }
    
    func numberOfItemsInSection() -> Int {
        guard let results = photoResults.value else {
            print("No data in photoResults")
            return 0
        }
//        print("count: \(results.count)")
        return results.count
    }
    
    func cellForItemData(indexPath: IndexPath) -> PhotoResult? {
        guard let photoResults = photoResults.value else {
            print("No data in photoResults for cell")
            return nil
        }
//        print("cell: \(photoResults[indexPath.item])")
        return photoResults[indexPath.item]
    }
    
    
    
}
