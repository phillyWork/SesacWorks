//
//  DataManager.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private let networkManager = NetworkManager()
    
    private var movieId = 419704
    
    private var movieList = [Movie]()
    private var videoList = [Video]()
    
    private var pageNum = 1
    
    //MARK: - GET
    
    func getMovieList() -> [Movie] {
        return movieList
    }
    
    func getVideoList() -> [Video] {
        return videoList
    }
    
    func getPageNum() -> Int {
        return pageNum
    }
    
    func getMovieId() -> Int {
        return movieId
    }
    
    //MARK: - Fetch
    
    func setupMovieList(type: EndPoint, movieId: Int, pageNum: Int, completionHandler: @escaping () -> ()) {
        
        //Result type 결과 받아서 switch로 분기 처리
        networkManager.fetchMovieList(type: type, movieId: movieId, pageNum: pageNum) { response in
            switch response {
            case .success(let success):
                self.movieList.append(contentsOf: success)
                print("Saving new movie data success")
                completionHandler()
            case .failure(let failure):
                print("Error: ", failure.localizedDescription)
                completionHandler()
            }
        }
    }
    
    func setupVideoList(type: EndPoint, movieId: Int, completionHandler: @escaping () -> ()) {
        
        networkManager.fetchVideoList(type: type, movieId: movieId) { response in
            switch response {
            case .success(let success):
                self.videoList.append(contentsOf: success)
                print("Saving new video list success")
                completionHandler()
            case .failure(let failure):
                print("Error: ", failure.localizedDescription)
                completionHandler()
            }
        }
    }
    
    
    //MARK: - Update
    
    func addPageNum() {
        pageNum += 1
    }
    
    func updateMovieID(id: Int) {
        movieId = id
    }
    
    func resetData() {
        movieList.removeAll()
        videoList.removeAll()
        pageNum = 1
    }
    
    
}
