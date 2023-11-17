//
//  Theater.swift
//  CoreLocationMapKitTheater
//
//  Created by Heedon on 2023/08/23.
//

import Foundation

struct Theater {
    
    enum TheaterType {
        case CGV
        case LotteCinema
        case MegaBox
    }
    
    let type: TheaterType
    let locationName: String
    let latitude: Double
    let longitude: Double
}
