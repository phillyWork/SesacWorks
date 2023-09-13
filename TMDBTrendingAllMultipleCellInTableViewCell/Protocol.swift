//
//  Protocol.swift
//  TMDBTrendingAllMultipleCellInTableViewCell
//
//  Created by Heedon on 2023/09/03.
//

import Foundation

//MARK: - ReuseableView identifier protocol

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

//MARK: - Show Alert in VC

protocol ShowAlertInVC {
    func showAlert(title: String, message: String)
}
