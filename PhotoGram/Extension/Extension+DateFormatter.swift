//
//  Extension+DateFormatter.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/29.
//

import Foundation

extension DateFormatter {
    
    //type property로 미리 선언, 가져다가 활용하기 (매번 instance 생성하는 것보다는)
    static let format = {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        return format
    }()
    
    static func today() -> String {
        return format.string(from: Date())
    }
    
    static func convertDate(date: Date) -> String {
        return format.string(from: date)
    }
    
}
