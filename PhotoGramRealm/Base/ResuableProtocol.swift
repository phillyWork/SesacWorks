//
//  ResuableProtocol.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit

//class 제약 설정
protocol ReusableViewProtocol: AnyObject {
    static var reuseIdentifier: String { get }
    
}

//MARK: - Extension for ReusableViewProtocol

//custom framework로 활용 예정: public 필요

extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
//  public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

