//
//  ReusableProtocol.swift
//  TMDBNetworkSingleton
//
//  Created by Heedon on 2023/08/11.
//

import UIKit

//매번 identifier 각자 작성하는 것보다 Protocol로 type property로 갖고 있도록 함
protocol ReusableViewProtocol {
    static var identifier: String { get }
}

//VC와 Cell이 이 protocol 채택 (conform): 해당 type property를 보유함
extension UIViewController: ReusableViewProtocol {
    //본인 이름을 String화
    static var identifier: String {
        return String(describing: self)
    }

}

extension UICollectionViewCell: ReusableViewProtocol {

    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: ReusableViewProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
