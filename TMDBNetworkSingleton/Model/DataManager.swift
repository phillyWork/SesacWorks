//
//  DataManager.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private let networkManager = NetworkManager.shared
    
    private var movieContents = [Movie]()
    private var castingLists = [Casting]()
    private var pageNum = 1
    
    //MARK: - GET

    func getContentsList() -> [Movie] {
        return movieContents
    }
    
    func getCastingList() -> [Casting] {
        return castingLists
    }
    
    func getPageNum() -> Int {
        return pageNum
    }
    
    
    //MARK: - UPDATE

    //networking 끝나고 작업 시작되어야 함
    func setMovieTrendList(type: EndPoint, page: Int?, completionHandler: @escaping () -> ()) {
        print("Setting up movie content...")
        networkManager.callRequest(type: type, movieId: nil, page: page) { json in
            
            let movieLists = json["results"].arrayValue
            for movie in movieLists {
                
                let title = movie["title"].stringValue
                let movieId = movie["id"].intValue
                let overview = movie["overview"].stringValue
                let backdropPath = movie["backdrop_path"].stringValue
                let posterPath = movie["poster_path"].stringValue
                let rate = movie["vote_average"].doubleValue
                let genreIds = movie["genre_ids"].arrayObject as! [Int]
                let releaseDate = movie["release_date"].stringValue
                
                let movieInstance = Movie(title: title, movieId: movieId, overview: overview, backdropPath: backdropPath, posterPath: posterPath, rate: rate, genreIds: genreIds, releaseDate: releaseDate)
                self.movieContents.append(movieInstance)
            }
            completionHandler()
        }
    }
    
    func setCastingList(type: EndPoint, movieId: Int, completionHandler: @escaping () -> ()) {
        
        //이전 영화 casting 목록 삭제
        castingLists.removeAll()
        
        networkManager.callRequest(type: type, movieId: movieId, page: nil) { json in
            let castList = json["cast"].arrayValue
            for cast in castList {
                let name = cast["name"].stringValue
                let character = cast["character"].stringValue
                let profilePath = cast["profile_path"].stringValue
                
                let castInstance = Casting(name: name, character: character, profilePath: profilePath)
                
                self.castingLists.append(castInstance)
            }
            completionHandler()
        }
    }

    func addPageNum() {
        pageNum += 1
    }

}
