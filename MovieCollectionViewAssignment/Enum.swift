//
//  Enum.swift
//  MovieCollectionViewAssignment
//
//  Created by Heedon on 2023/07/31.
//

import UIKit

enum MoviePosterTitle: String {
    case assassination = "암살"
    case myungryang = "명량"
    case kwangHae = "광해"
    case headToBusan = "부산행"
    case avatar = "아바타"
    case avengers = "어벤져스엔드게임"
    case haeundae = "해운대"
    case presentOf7thRoom = "7번방의선물"
    case frozenTwo = "겨울왕국2"
    
    var posterImage: UIImage {
        return UIImage(named: self.rawValue)!
    }
    
}
