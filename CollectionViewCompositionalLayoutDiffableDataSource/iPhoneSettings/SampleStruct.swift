//
//  SampleStruct.swift
//  CollectionViewCompositionalLayoutDiffableDataSource
//
//  Created by Heedon on 2023/09/15.
//

import Foundation

enum EachCase {
    case focus
    case sleep
    case workTime
    case privateTime
    
    var title: String {
        switch self {
        case .focus:
            return "방해 금지 모드"
        case .sleep:
            return "수면"
        case .workTime:
            return "업무"
        case .privateTime:
            return "개인 시간"
        }
    }
    
    var imageString: String {
        switch self {
        case .focus:
            return "moon.fill"
        case .sleep:
            return "bed.double.fill"
        case .workTime:
            return "lanyardcard.fill"
        case .privateTime:
            return "person.fill"
        }
    }
    
    
}

struct Sample: Hashable {
    let title: String
    let systemImageString: String?

    let id = UUID().uuidString
}
