//
//  ShoppingMainViewModel.swift
//  ShoppingListWithRX
//
//  Created by Heedon on 2023/11/05.
//

import Foundation

import RxSwift
import RxCocoa

final class ShoppingMainViewModel {
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    lazy var items = BehaviorRelay(value: shoppingList)

}
