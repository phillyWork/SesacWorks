//
//  VideoList.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import Foundation

// MARK: - VideoList
struct VideoList: Codable {
    let id: Int
    let videoList: [Video]
    
    enum CodingKeys: String, CodingKey {
        case id
        case videoList = "results"
    }
}

// MARK: - Result
struct Video: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    
    var yyyyMMddReleaseDate: String {
        //yyyy MM dd T HH:mm:ss Z
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate]
        let dateFromPublish = dateFormatter.date(from: publishedAt)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy-MM-dd"
        return dateFormatter2.string(from: dateFromPublish!)
    }
}
