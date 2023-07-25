//
//  DataManager.swift
//  enumTagAssignment
//
//  Created by Heedon on 2023/07/25.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private var countArray = [0, 0, 0, 0, 0]
    private var emotions = Emotion.allCases
    
    func updateArray(tag: Int) {
        countArray[tag-1] += 1
        printResult(tag: tag)
    }
    
    func updateArrayWithFive(tag: Int) {
        countArray[tag-1] += 5
        printResult(tag: tag)
    }
    
    func updateArrayWithTen(tag: Int) {
        countArray[tag-1] += 10
        printResult(tag: tag)
    }
    
    func updateArrayWithResest(tag: Int) {
        countArray[tag-1] = 0
        printResult(tag: tag)
    }
    
    private func printResult(tag: Int) {
        print("\(emotions[tag-1]) \(countArray[tag-1])번 눌렸습니다.")
    }
    
    func getArrayData() -> [Int] {
        return countArray
    }
    
    
    
}
