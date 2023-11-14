//
//  MovieStruct.swift
//  RxSwiftMovieAPI
//
//  Created by Heedon on 2023/11/07.
//

import Foundation

struct MovieStruct: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let movieNm, openDt: String
}
