//
//  Extension+ReusableViewProtocol.swift
//  MultipleCellExample
//
//  Created by Heedon on 2023/09/01.
//

import UIKit

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
