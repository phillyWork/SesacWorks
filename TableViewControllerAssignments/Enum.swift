//
//  Enum.swift
//  TableViewControllerAssignments
//
//  Created by Heedon on 2023/07/27.
//

import UIKit

enum SectionHeader: Int, CaseIterable {
    case wholeSetting = 0
    case personalSetting
    case remainSetting
    
    var sectionName: String {
        switch self {
        case .wholeSetting:
            return "전체 설정"
        case .personalSetting:
            return "개인 설정"
        case .remainSetting:
            return "기타"
        }
    }
}


//SectionHeader(rawValue: section) --> 해당 case
//해당 case --> SectionDataType의 case로 연결
enum SectionHeaderToDataType {
    case wholeSetting
    case personalSetting
    case remainSetting
    
    var bridge: SectionHeader {
        switch self {
        case .wholeSetting:
            return SectionHeader.wholeSetting
        case .personalSetting:
            return SectionHeader.personalSetting
        case .remainSetting:
            return SectionHeader.remainSetting
        }
    }
}



enum Star: String {
    case emptyStar = "☆"
    case fullStar = "★"

    var afterSelection: String {
        switch self {
        case .emptyStar:
            return "★"
        case .fullStar:
            return "☆"
        }
    }
}
