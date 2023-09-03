//
//  Protocol.swift
//  MultipleCellExample
//
//  Created by Heedon on 2023/09/01.
//

import Foundation

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

//MARK: - Show Alert in VC

protocol ShowAlertInVC {
    func showAlert(title: String, message: String)
}
