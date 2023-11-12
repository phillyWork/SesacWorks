//
//  RandomPhotoStruct.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/18.
//

import Foundation

// MARK: - RandomPhoto
struct RandomPhoto: Codable {
    let urls: Urls
    let links: RandomPhotoLinks
}

// MARK: - RandomPhotoLinks
struct RandomPhotoLinks: Codable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}

// MARK: - Urls
struct Urls: Codable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}
