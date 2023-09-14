//
//  Protocol.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/03.
//

import Foundation

@objc
protocol UIViewSetting {
    
    func configNavBar()
    
    @objc optional func configLabel()
    @objc optional func configButton()
    
    @objc optional func configTextField()
    @objc optional func configTextView()
    
    @objc optional func configCollectionView()
    @objc optional func configTableView()
   
}
