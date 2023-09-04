//
//  Protocol.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import UIKit

protocol ReusableViewProtocol {
    static var identifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

//collectionViewCell: ReusableView 상속
extension UICollectionReusableView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
}
