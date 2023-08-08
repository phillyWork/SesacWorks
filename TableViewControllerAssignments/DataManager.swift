//
//  DataManager.swift
//  TableViewControllerAssignments
//
//  Created by Heedon on 2023/07/27.
//

import Foundation


class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    //CaseTwo
    private let wholeSetting = ["공지사항", "실험실", "버전 정보"]
    private let personalSetting = ["개인/보안", "알림", "채팅", "멀티프로필"]
    private let remainSetting = ["고객센터/도움말"]
    
    //CaseThree
    private var workToDo = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    private let stars = ["☆", "★"]
    
    //CaseTwo의 3가지 데이터 enum으로 연결
    //함수 하나로 알아서 return하도록 만들기
//    enum SectionDataType {
//        case wholeSetting
//        case personalSetting
//        case remainSetting
//    }
    

    func getFromStart(type: SectionHeader) -> [String] {
        switch type {
        case .wholeSetting:
            return wholeSetting
        case .personalSetting:
            return personalSetting
        case .remainSetting:
            return remainSetting
        }
    }
    
    
//    func getDatatype(type: SectionHeader) -> SectionDataType {
//        switch type {
//        case .wholeSetting:
//            return SectionDataType.wholeSetting
//        case .personalSetting:
//            return SectionDataType.personalSetting
//        case .remainSetting:
//            return SectionDataType.remainSetting
//        }
//    }
//
//    func getData(type: SectionDataType)  -> [String]  {
//        switch type {
//        case .wholeSetting:
//            return wholeSetting
//        case .personalSetting:
//            return personalSetting
//        case .remainSetting:
//            return remainSetting
//        }
//    }

//    func getWholeSetting() -> [String] {
//        return wholeSetting
//    }
//
//    func getPersonalSetting() -> [String] {
//        return personalSetting
//    }
//
//    func getRemainSetting() -> [String] {
//        return remainSetting
//    }
    
    func getSectionCount() -> Int {
        return SectionHeader.allCases.count
    }
    
    
    //MARK: - CaseThree
    
    func getWorkToDo() -> [String] {
        return workToDo
    }
    
    func getStars() -> [String] {
        return stars
    }
    
    func addWorkData(chore: String) {
        workToDo.append(chore)
    }
    
    
    
}
