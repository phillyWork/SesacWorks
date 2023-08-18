//
//  Book.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import Foundation

struct Book: Equatable {
    let title: String
    let releaseDate: String
    let runtime: Int
    let overview: String
    let rate: Double
    var like: Bool
    var color: [CGFloat]
    
    //원래는 연도와 책 카테고리
    //예시로는 연도와 러닝타임 한꺼번에 보여주기
    var yearAndCategory: String {
        get {
            return "\(releaseDate) • \(runtime)"
        }
    }
}
