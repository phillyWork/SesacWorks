//
//  WalletModel.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/22/23.
//

import SwiftUI

struct WalletModel: Hashable, Identifiable {
    let id = UUID()     //view 정보 전달, animation 관련 같은 group 인지시켜 주기
    let color = Color.random()  //순수 모델 활용 목적: 숫자값 전달하기
    let name: String
    let index: Int
}

var walletList = [
    WalletModel(name: "Hue card", index: 0),
    WalletModel(name: "Jack card", index: 1),
    WalletModel(name: "Bran card", index: 2),
    WalletModel(name: "Koko card", index: 3)
]
