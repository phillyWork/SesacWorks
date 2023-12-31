//
//  BeerStruct.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import Foundation

struct Beer: Decodable, Hashable {
    let id: Int
    let name: String
    let description: String
    let image_url: String
    
    let itemId = UUID().uuidString
}
