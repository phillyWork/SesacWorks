//
//  NotUsingGenericEachNetworking.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/29.
//

//Not using generic function, networking each case


//MARK: - Trending Movie
//func callRequestTrendMovie(type: DataUrl, page: Int, completionHandler: @escaping (Result<[Movie], AFError>) -> ()) {
//    let url = type.requestURL + "?page=\(page)"
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: TrendMovie.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting MovieList successful")
//            completionHandler(.success(value.movieList))
//        case .failure(let error):
//            print("Failed to get movie list")
//            completionHandler(.failure(error))
//        }
//    }
//}

//MARK: - Casting
//func callRequestCastingList(type: DataUrl, movieId: Int, completionHandler: @escaping (Result<[Cast], AFError>) -> ()) {
//    let url = type.requestURL + "\(movieId)/credits"
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: CastingList.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting CastList successful")
//            completionHandler(.success(value.cast))
//        case .failure(let error):
//            print("Failed to get cast list")
//            completionHandler(.failure(error))
//        }
//    }
//}

//MARK: - Trending TV
//func callRequestTrendTV(type: DataUrl, page: Int, completionHandler: @escaping (Result<[TVSeries], AFError>) -> ()) {
//    let url = type.requestURL + "?page=\(page)"
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: TrendTVResult.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting TVList successful")
//            completionHandler(.success(value.tvLists))
//        case .failure(let error):
//            print("Failed to get tv list")
//            completionHandler(.failure(error))
//        }
//    }
//}

//MARK: - Season Lists
//func callRequestSeasonList(type: DataUrl, seriesId: Int, completionHandler: @escaping (Result<[Season], AFError>) -> ()) {
//    let url = type.requestURL + "\(seriesId)"
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: TVDetail.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting SeasonList successful")
//            completionHandler(.success(value.seasons))
//        case .failure(let error):
//            print("Failed to get season list")
//            completionHandler(.failure(error))
//        }
//    }
//}

//MARK: - Episode Lists
//func callReqeustEpisodeList(type: DataUrl, seriesId: Int, seasonNumber: Int, completionHandler: @escaping (Result<[Episode], AFError>) -> ()) {
//    let url = type.requestURL + "\(seriesId)/season/\(seasonNumber)"
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: SeasonDetail.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting EpisodeList successful")
//            completionHandler(.success(value.episodes))
//        case .failure(let error):
//            print("Failed to get episode list")
//            completionHandler(.failure(error))
//        }
//    }
//}

//MARK: - Similar Movie Lists
//func callRequestSimilarMovieList(type: DataUrl, movieId: Int, page: Int, completionHandler: @escaping (Result<[SimilarMovie], AFError>) -> ()) {
//    let url = URL.makeDataURLString("\(movieId)"+type.requestURL+"\(page)")
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: SimilarMovieList.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting Similar Movie List successful")
//            completionHandler(.success(value.movieList))
//        case .failure(let error):
//            print("Failed to get similar movie list")
//            completionHandler(.failure(error))
//        }
//    }
//}

//MARK: - Video Lists
//func callRequestVideoLlist(type: DataUrl, movieId: Int, completionHandler: @escaping (Result<[Video], AFError>) -> ()) {
//    let url = URL.makeDataURLString("\(movieId)"+type.requestURL)
//    AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: VideoList.self) { response in
//        switch response.result {
//        case .success(let value):
//            print("Getting Video List successful")
//            completionHandler(.success(value.videoList))
//        case .failure(let error):
//            print("Failed to get video list")
//            completionHandler(.failure(error))
//        }
//    }
//}
