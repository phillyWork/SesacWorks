//
//  LottoStruct.swift
//  BeerAndLotteryAPI
//
//  Created by Heedon on 2023/09/13.
//

import Foundation

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, date: String
    let firstWinamnt, sixthNum, fourthNum, firstPrzwnerCo: Int
    let fifthNum, bonusNum, firstAccumamnt, drawingTimes: Int
    let secondNum, thirdNum, firstNum: Int
    
    enum CodingKeys: String, CodingKey {
        case totSellamnt
        case returnValue
        case date = "drwNoDate"
        case firstWinamnt
        case firstPrzwnerCo
        case firstAccumamnt
        case drawingTimes = "drwNo"
        case firstNum = "drwtNo1"
        case secondNum = "drwtNo2"
        case thirdNum = "drwtNo3"
        case fourthNum = "drwtNo4"
        case fifthNum = "drwtNo5"
        case sixthNum = "drwtNo6"
        case bonusNum = "bnusNo"
    }
    
    var resultNumberList: String {
        return "\(firstNum) • \(secondNum) • \(thirdNum) • \(fourthNum) • \(fifthNum) • \(sixthNum) • \(bonusNum)"
    }
}
