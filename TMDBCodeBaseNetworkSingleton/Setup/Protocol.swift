//
//  Protocol.swift
//  TMDBCodeBaseNetworkSingleton
//
//  Created by Heedon on 2023/08/28.
//

import Foundation

//MARK: - Protocol for View Identifiers

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

//MARK: - Delegate for Data Transfer

protocol AgeSetupDelegate {
    func receiveAge(ageText: String)
}
