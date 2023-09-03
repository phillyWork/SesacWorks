//
//  DataManager.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation
import Alamofire

class DataManager {
    
    static let shared = DataManager()
    private init() { }
        
    //MARK: - Properties
    
    private let networkManager = NetworkManager()
    
//    private var trendMovieList = [Movie]()
//    private var trendTVList = [TVSeries]()

    private var trendList = [Trend]()
    private var castingList = [Cast]()
    
    private var seasonList = [Season]()
    private var episodeDictionary: [Int: [Episode]] = [:]
    
    private var similarList = [Similar]()
    private var videoList = [Video]()
    
    private var pageNumForTrend = 1
    private var pageNumForSimilar = 1
    
    private var profile = Profile(name: "User", age: 20, email: "example@gmail.com")
    
    //MARK: - GET
    
    func getAllTrend() -> [Trend] {
        return trendList
    }
    
    func getMovieTrend() -> [Trend] {
        return trendList.filter { $0.mediaType == .movie }
    }
    
    func getTVTrend() -> [Trend] {
        return trendList.filter { $0.mediaType == .tv }
    }
        
    func getCastingList() -> [Cast] {
        return castingList
    }
    
    func getSeasonList() -> [Season] {
        return seasonList
    }
    
    func getEpisodeList(seasonNumber: Int) -> [Episode]? {
        return episodeDictionary[seasonNumber]
    }
    
    func getSimilarList() -> [Similar] {
        return similarList
    }
    
    func getVideoList() -> [Video] {
        return videoList
    }
    
    func getPageNumForTrend() -> Int {
        return pageNumForTrend
    }
    
    func getPageNumForSimilar() -> Int {
        return pageNumForSimilar
    }
    
    func getProfile() -> Profile {
        return profile
    }
    
    //MARK: - UPDATE
    func setupAllTrendList(type: DataUrl, page: Int, completionHandler: @escaping () -> ()) {
        networkManager.callRequest(type: type, page: page, movieId: nil, seriesId: nil, seasonNumber: nil) { (result: Result<TrendingAllList, AFError>) in
            switch result {
            case .success(let success):
                self.trendList.append(contentsOf: success.trendingList)
                completionHandler()
            case .failure(let failure):
                print("Trend TV Error: ", failure.localizedDescription)
                completionHandler()
            }
        }
        
    }
    
    func setupCastingList(type: DataUrl, movieId: Int?, seriesId: Int?, completionHandler: @escaping () -> ()) {
        networkManager.callRequest(type: type, page: nil, movieId: movieId, seriesId: seriesId, seasonNumber: nil) { (result: Result<CastingList, AFError>) in
            switch result {
            case .success(let success):
                self.castingList = success.cast
                completionHandler()
            case .failure(let failure):
                print("Casting List Error: ", failure.localizedDescription)
                completionHandler()
            }
        }
    }
        
    func setupSeasonList(type: DataUrl, seriesId: Int, completionHandler: @escaping () -> ()) {
//        networkManager.callRequestSeasonList(type: type, seriesId: seriesId) { result in
//            switch result {
//            case .success(let success):
//                self.seasonList.append(contentsOf: success)
//                completionHandler()
//            case .failure(let failure):
//                print("Season List Error: ", failure.localizedDescription)
//                completionHandler()
//            }
//        }
    }
    
    func setupEpisodeList(type: DataUrl, seriesId: Int, seasonNumber: Int, completionHandler: @escaping () -> ()) {
//        networkManager.callReqeustEpisodeList(type: type, seriesId: seriesId, seasonNumber: seasonNumber) { result in
//            switch result {
//            case .success(let success):
//                self.episodeDictionary[seasonNumber] = success
//                completionHandler()
//            case .failure(let failure):
//                self.episodeDictionary[seasonNumber] = []
//                print("Episode List Failure: ", failure.localizedDescription)
//                completionHandler()
//            }
//        }
    }
    
    func setupSimilarList(type: DataUrl, movieId: Int?, seriesId: Int?, pageNum: Int, completionHandler: @escaping () -> ()) {
        networkManager.callRequest(type: type, page: pageNum, movieId: movieId, seriesId: seriesId, seasonNumber: nil) { (result: Result<SimilarList, AFError>) in
            switch result {
            case .success(let success):
                self.similarList = success.list
                completionHandler()
            case .failure(let failure):
                print("Similar List Failure: ", failure.localizedDescription)
            }
        }
    }
    
    func setupVideoList(type: DataUrl, movieId: Int?, seriesId: Int?, completionHandler: @escaping () -> ()) {
        networkManager.callRequest(type: type, page: nil, movieId: movieId, seriesId: seriesId, seasonNumber: nil) { (result: Result<VideoList, AFError>) in
            switch result {
            case .success(let success):
                self.videoList = success.videoList
                completionHandler()
            case .failure(let failure):
                print("Video List Failure: ", failure.localizedDescription)
            }
        }
    }
    
    func addTrendPageNum() {
        pageNumForTrend += 1
    }
    
    func addSimilarPageNum() {
        pageNumForSimilar += 1
    }
    
    func resetData() {
        similarList.removeAll()
        videoList.removeAll()
//        pageNumForTrend = 1
        pageNumForSimilar = 1
    }
    
    func updateProfile(newProfile: Profile) {
        profile = newProfile
    }
    
}
