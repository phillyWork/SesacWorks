//
//  DataManager.swift
//  MovieTableViewAssignment
//
//  Created by Heedon on 2023/07/28.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private let movieData = MovieInfo().movie
    
    func getData() -> [Movie] {
        return movieData
    }

    //연산 프로퍼티 활용, 굳이 함수 안쓰고 활용하기
//    func getPosterImage(type: MovieTitle) -> UIImage {
//        switch type {
//        case .assassination:
//            return assassination!
//        case .myungryang:
//            return myungryang!
//        case .kwangHae:
//            return kwangHae!
//        case .headToBusan:
//            return headToBusan!
//        case .avatar:
//            return avatar!
//        case .avengers:
//            return avengers!
//        case .haeundae:
//            return haeundae!
//        case .presentOf7thRoom:
//            return presentOf7thRoom!
//        case .frozenTwo:
//            return frozenTwo!
//        }
//    }
    
}
