//
//  Enum.swift
//  enumTagAssignment
//
//  Created by Heedon on 2023/07/25.
//

import Foundation

enum Emotion: Int, CaseIterable {
    case happy = 1
    case smile
    case soso
    case sad
    case tear
    
    var name: String {
        switch self {
        case .happy:
            return "happy"
        case .smile:
            return "smile"
        case .soso:
            return "soso"
        case .sad:
            return "sad"
        case .tear:
            return "tear"
        }
    }
    
}

//Emotion type의 instance
//let emotion = Emotion(rawValue: sender.tag)

//instance의 property 접근
//let emotionInString = emotion?.name

