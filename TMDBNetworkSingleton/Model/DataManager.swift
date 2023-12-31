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
    
    private var movieContents = [MovieJSON]()
    private var castingLists = [CastingJSON]()
    
    private var movieTrendDecodableStruct = [Movie]()
    private var castingListDeocdableStruct = [Cast]()
    
    private var pageNum = 1
    
    //MARK: - GET

    func getContentsList() -> [Movie] {
        return movieTrendDecodableStruct
    }
    
//    func getContentsList() -> [Movie] {
//        return movieContents
//    }
    
    func getCastingList() -> [Cast] {
        return castingListDeocdableStruct
    }
    
//    func getCastingList() -> [Casting] {
//        return castingLists
//    }
    
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
                
                let movieInstance = MovieJSON(title: title, movieId: movieId, overview: overview, backdropPath: backdropPath, posterPath: posterPath, rate: rate, genreIds: genreIds, releaseDate: releaseDate)
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
                
                let castInstance = CastingJSON(name: name, character: character, profilePath: profilePath)
                
                self.castingLists.append(castInstance)
            }
            completionHandler()
        }
    }
    
    func addPageNum() {
        pageNum += 1
    }
    
    //MARK: - With Decodable Update
    
    func setMovieTrendListWithDecodableStruct(type: EndPoint, page: Int, completionHandler: @escaping () -> ()) {
        //응답값을 구조체에 담아버림 (하나하나 반복문으로 data를 담을 필요 없음)
        networkManager.callTrendMovieRequestWithDecodableStructure(type: type, page: page) { result in
            switch result {
            case .success(let success):
                self.movieTrendDecodableStruct.append(contentsOf: success)
                print("saving new movie list succeed")
                completionHandler()
            case .failure(let failure):
                print("Error: ", failure.localizedDescription)
                completionHandler()
            }
            
            
        }
    }
    
    func setCastingListWithDecodableStruct(type: EndPoint, movieId: Int, completionHandler: @escaping () -> ()) {
        //이전 영화 casting 목록 삭제
        castingListDeocdableStruct.removeAll()
        
        networkManager.callCasintListRequestWithDecodableStructure(type: type, movieId: movieId) { result in
            switch result {
            case .success(let success):
                self.castingListDeocdableStruct.append(contentsOf: success)
                print("saving new cast list succeed")
                completionHandler()
            case .failure(let failure):
                print("Error: ", failure.localizedDescription)
                completionHandler()
            }
        }
    }
    
    

}
