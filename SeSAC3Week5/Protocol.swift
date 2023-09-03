//
//  Protocol.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/17.
//

import UIKit

//MARK: - ReusableViewProtocol

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

extension UICollectionReusableView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}

//MARK: - CollectionViewAttributeProtocol

//여러 VC에서 table/collectionview 반복 활용 --> 등록, 설정 작업 반복
//protocol로 function 만들어서 바로 작업하도록 관리
protocol CollectionViewAttributeProtocol {
    func configureCollectionView()
    func configureCollectionViewLayout()
}


