//
//  DataManager.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    let networkManager = NetworkManager()
    
    private var seasonList = [Season]()
//    private var episodeList = [Episode]()
    
    private var seasonEpisodeDictionary: [Int: [Episode]] = [:]
    
    //MARK: - GET
    
    func getSeasonList() -> [Season] {
        return seasonList
    }
    
    func getEpisodeList(seasonNumber: Int) -> [Episode]? {
//        return episodeList
        return seasonEpisodeDictionary[seasonNumber]
    }
    
    //MARK: - Fetch
//    func fetchTVId() {
//
//    }
    
    func fetchSeasonList(type: EndPoint, seriesId: Int, completionHandler: @escaping () -> ()) {
        networkManager.fetchTVDetail(type: type, seriesId: seriesId) { seasonList in
            self.seasonList = seasonList
            print("season total: \(self.seasonList.count)")
            completionHandler()
        }
    }
    
    func fetchEpisodeList(type: EndPoint, seriesId: Int, seasonNumber: Int, completionHandler: @escaping () -> ()) {
        networkManager.fetchSeasonDetail(type: type, seriesId: seriesId, seasonNumber: seasonNumber) { episodeList in
//            self.episodeList = episodeList
            self.seasonEpisodeDictionary[seasonNumber] = episodeList
            print("season \(seasonNumber)'s episode count: \(self.seasonEpisodeDictionary[seasonNumber]?.count)")
            completionHandler()
        }
    }
    
}
