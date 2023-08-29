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
    
    private var trendMovieList = [Movie]()
    private var castingList = [Cast]()
    
    private var trendTVList = [TVSeries]()
    private var seasonList = [Season]()
    private var episodeDictionary: [Int: [Episode]] = [:]
    
    private var similarMovieList = [SimilarMovie]()
    private var videoList = [Video]()
    
    private var movieId: Int?
    
    private var pageNumForTrend = 1
    private var pageNumForSimilar = 1
    
    private var profile = Profile(name: "User", age: 20, email: "example@gmail.com")
    
    //MARK: - GET
    
    func getMovieTrend() -> [Movie] {
        return trendMovieList
    }
    
    func getCastingList() -> [Cast] {
        return castingList
    }
    
    func getTvTrend() -> [TVSeries] {
        return trendTVList
    }
    
    func getSeasonList() -> [Season] {
        return seasonList
    }
    
    func getEpisodeList(seasonNumber: Int) -> [Episode]? {
        return episodeDictionary[seasonNumber]
    }
    
    func getSimilarMovie() -> [SimilarMovie] {
        return similarMovieList
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
    
    func getMovieID() -> Int {
        return movieId ?? 671
    }
    
    func getProfile() -> Profile {
        return profile
    }
    
    //MARK: - UPDATE
    
    func setupMovieTrendList(type: DataUrl, page: Int, completionHandler: @escaping () -> ()) {
        networkManager.callRequest(type: type, page: page, movieId: nil, seriesId: nil, seasonNumber: nil) { (result: Result<TrendMovie, AFError>) in
            switch result {
            case .success(let success):
                self.trendMovieList.append(contentsOf: success.movieList)
                completionHandler()
            case .failure(let failure):
                print("Trend Movie Error: ", failure.localizedDescription)
                completionHandler()
            }
        }
    }
    
    func setupCastingList(type: DataUrl, movieId: Int, completionHandler: @escaping () -> ()) {
        networkManager.callRequest(type: type, page: nil, movieId: movieId, seriesId: nil, seasonNumber: nil) { (result: Result<CastingList, AFError>) in
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
    
    func setupTVTrendList(type: DataUrl, page: Int, completionHandler: @escaping () -> ()) {
//        networkManager.callRequestTrendTV(type: type, page: page) { result in
//            switch result {
//            case .success(let success):
//                self.trendTVList.append(contentsOf: success)
//                completionHandler()
//            case .failure(let failure):
//                print("Trend TV Error: ", failure.localizedDescription)
//                completionHandler()
//            }
//        }
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
    
    func setupSimilarMovieList(type: DataUrl, movieId: Int, pageNum: Int, completionHandler: @escaping () -> ()) {
//        networkManager.callRequestSimilarMovieList(type: type, movieId: movieId, page: pageNum) { result in
//            switch result {
//            case .success(let success):
//                self.similarMovieList.append(contentsOf: success)
//                completionHandler()
//            case .failure(let failure):
//                print("Similar Movie List Failure: ", failure.localizedDescription)
//                completionHandler()
//            }
//        }
    }
    
    func setupVideoList(type: DataUrl, movieId: Int, completionHandler: @escaping () -> ()) {
//        networkManager.callRequestVideoLlist(type: type, movieId: movieId) { result in
//            switch result {
//            case .success(let success):
//                self.videoList.append(contentsOf: success)
//                completionHandler()
//            case .failure(let failure):
//                print("Video List Error: ", failure.localizedDescription)
//                completionHandler()
//            }
//        }
    }
    
    func addPageNum() {
        pageNumForTrend += 1
    }
    
    func updateMovieID(newMovieId: Int) {
        movieId = newMovieId
    }
    
    func resetData() {
        similarMovieList.removeAll()
        videoList.removeAll()
        pageNumForTrend = 1
    }
    
    func updateProfile(newProfile: Profile) {
        profile = newProfile
    }
    
}
