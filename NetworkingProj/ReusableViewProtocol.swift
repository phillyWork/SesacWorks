//
//  Protocol.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import UIKit

//identifier를 type property: 매번 모든 cell에 직접 static let 선언해야 함
//더 간결하게 활용해보기

protocol ReusableViewProtocol {
    //type 연산 property: 매 View 마다 이름 다르게 설정되어야 함
    static var identifier: String { get }
}

//주로 VC 혹은 Cell 계열들 활용
extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        //자기 자신의 이름을 String화
        return String(describing: self)
    }
    
    
}

extension UITableViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
    
}
