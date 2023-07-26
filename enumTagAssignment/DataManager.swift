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
    
//    private var countArray = [0, 0, 0, 0, 0]
//    private var emotions = Emotion.allCases
    
    private var countDict = [String: Int]()
    
    func checkDictData(tag: Int, count: Int) {
        //Emotion type의 instance
        let emotion = Emotion(rawValue: tag)
        
        //instance의 property 접근
        if let emotionName = emotion?.name {
            if count == 0 {
                countDict[emotionName] = 0
            } else {
                if countDict[emotionName] != nil {
                    countDict[emotionName]! += count
                } else {
                    countDict[emotionName] = count
                }
            }
        } else {
            print("접근한 버튼에 연관된 감정이 없습니다.")
        }
    }
    
    
    func updateData(tag: Int) {
//        countArray[tag-1] += 1
        printResult(tag: tag, count: 1)
    }
    
    func updateDataFiveTimes(tag: Int) {
//        countArray[tag-1] += 5
        printResult(tag: tag, count: 5)
    }
    
    func updateDataTenTimes(tag: Int) {
//        countArray[tag-1] += 10
        printResult(tag: tag, count: 10)
    }
    
    func resetData(tag: Int) {
//        countArray[tag-1] = 0
        printResult(tag: tag, count: 0)
    }
    
    private func printResult(tag: Int, count: Int) {
        checkDictData(tag: tag, count: count)
        if let emotionName = Emotion(rawValue: tag)?.name, let emotionCount = countDict[emotionName] {
            print("\(emotionName) \(emotionCount)번 눌렸습니다.")
        }
//        print("\(emotions[tag-1]) \(countArray[tag-1])번 눌렸습니다.")
    }
    
//    func getArrayData() -> [Int] {
//        return countArray
//    }
   
    func getData() -> [String: Int] {
        return countDict
    }
    
    func saveData() {
        UserDefaults.standard.set(countDict, forKey: "countDict")
//        UserDefaults.standard.set(countArray, forKey: "countArray")
    }
    
    func retrieveData() {
        guard let retrievedData = UserDefaults.standard.object(forKey: "countDict") as? [String: Int] else {
            print("불러올 데이터가 없습니다.")
            return
        }
        countDict = retrievedData
        
//        guard let retrievedArray = UserDefaults.standard.object(forKey: "countArray") as? [Int] else {
//            countArray = [0, 0, 0, 0, 0]
//            return
//        }
//        countArray = retrievedArray
    }
    
    
}
