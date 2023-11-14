//
//  Protocol.swift
//  TMDBSegmentControlDispatchGroup
//
//  Created by Heedon on 2023/08/18.
//

import Foundation

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

protocol CollectionViewConfigProtocol {
    func configCollectionView()
    func configCollectionViewLayout()
}

@objc
protocol SetupUIProtocol {
    @objc optional func setupSegment()
    @objc optional func setupSearchBar()
}
