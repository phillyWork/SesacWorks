//
//  Book.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/08.
//

import Foundation

//        title    String    도서 제목
//        contents    String    도서 소개
//        url    String    도서 상세 URL
//        isbn    String    ISBN10(10자리) 또는 ISBN13(13자리) 형식의 국제 표준 도서번호(International Standard Book Number)
//        ISBN10 또는 ISBN13 중 하나 이상 포함, 두 값이 모두 제공될 경우 공백(' ')으로 구분
//        datetime    Datetime    도서 출판날짜, ISO 8601 형식
//        [YYYY]-[MM]-[DD]T[hh]:[mm]:[ss].000+[tz]
//        authors    String[]    도서 저자 리스트
//        publisher    String    도서 출판사
//        translators    String[]    도서 번역자 리스트
//        price    Integer    도서 정가
//        sale_price    Integer    도서 판매가
//        thumbnail    String    도서 표지 미리보기 URL

struct Book {
    let title: String
    let author: String
    let contents: String
    let isbn: String
    let date: String
    let thumbnailURL: String
    let price: Int
    var like: Bool
    var color: [CGFloat]
    
    static func randomColor() -> [CGFloat] {
        let cgRed = CGFloat.random(in: 0...255)/255
        let cgGreen = CGFloat.random(in: 0...255)/255
        let cgBlue = CGFloat.random(in: 0...255)/255
        
        return [cgRed, cgGreen, cgBlue]
    }
    
    var description: String {
        return "\(author) | \(date)"
    }
}
