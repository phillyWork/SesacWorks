//
//  PhotoStruct.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation

//Unsplash 데이터 필요한 정보만 받기

//Codable: Decodable + Encodable

//Hashable: Diffable에서 Item 고유성 확보 목적

struct Photo: Decodable, Hashable {
    let total: Int
    let total_pages: Int
    let results: [PhotoResult]
}

struct PhotoResult: Decodable, Hashable {
    let id: String
    let created_at: String
    let urls: PhotoURL
    
    //새로 추가: 각 cell마다 나타날 이미지 estimated 높이 설정 필요 ~ 비율 계산 필요
    let width: CGFloat
    let height: CGFloat
}

struct PhotoURL: Decodable, Hashable {
    let full: String
    let thumb: String
}
