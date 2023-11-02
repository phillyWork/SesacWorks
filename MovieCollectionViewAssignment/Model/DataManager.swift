//
//  DataManager.swift
//  MovieCollectionViewAssignment
//
//  Created by Heedon on 2023/07/31.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private let movieData = MovieInfo().movie
    
    
    func getTotalMovie() -> [Movie] {
        return movieData
    }
    
    
    
}
