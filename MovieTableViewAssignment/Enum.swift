//
//  Enum.swift
//  MovieTableViewAssignment
//
//  Created by Heedon on 2023/07/28.
//

import UIKit

enum MovieTitle: String {
    
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
        switch self {
        case .assassination:
            //return assassination: scope Error ~ Constant로 만든 image가 아니라 위의 case로 인식
            //image상수들 이름 변경 필요
            return assassinationImage!
        case .myungryang:
            return myungryangImage!
        case .kwangHae:
            return kwangHaeImage!
        case .headToBusan:
            return headToBusanImage!
        case .avatar:
            return avatarImage!
        case .avengers:
            return avengersImage!
        case .haeundae:
            return haeundaeImage!
        case .presentOf7thRoom:
            return presentOf7thRoomImage!
        case .frozenTwo:
            return frozenTwoImage!
        }
    }
    
    //다른 방식: 이미지 이름과 영화 이름 동일 가정
    //MovieTitle의 case 받아서 Constant로 이미지를 만들지 않고 직접 생성
    //switch 없이 바로 생성해서 Return 가능
    var posterImageTwo: UIImage {
        return UIImage(named: self.rawValue)!
    }
    
}
