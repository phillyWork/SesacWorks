//
//  ViewController.swift
//  enumTagAssignment
//
//  Created by Heedon on 2023/07/25.
//

import UIKit

class ButtonViewController: UIViewController {

//    var countArray = [0, 0, 0, 0, 0]
//
//    var emotions = Emotion.allCases
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func emojiButtonTapped(_ sender: UIButton) {
        
        dataManager.updateArray(tag: sender.tag)
        
        //3. before using singleton
//        countArray[sender.tag-1] += 1
//        print("\(emotions[sender.tag-1]) \(countArray[sender.tag-1])번 눌렸습니다.")
        
        //2. before using tag to both array and enum
//        switch emotions[sender.tag-1] {
//        case .happy:
//            countArray[sender.tag-1] += 1
//            print("\(Emotion.happy) \(countArray[0])번 눌렸습니다.")
//        case .smile:
//            countArray[1] += 1
//            print("\(Emotion.smile) \(countArray[1])번 눌렸습니다.")
//        case .soso:
//            countArray[2] += 1
//            print("\(Emotion.soso) \(countArray[2])번 눌렸습니다.")
//        case .sad:
//            countArray[3] += 1
//            print("\(Emotion.sad) \(countArray[3])번 눌렸습니다.")
//        case .tear:
//            countArray[4] += 1
//            print("\(Emotion.tear) \(countArray[4])번 눌렸습니다.")
//        }

        //1. before using enum.allCases
//        switch Emotion(rawValue: sender.tag) {
//        case .happy:
//            countArray[0] += 1
//            print("\(Emotion.happy) \(countArray[0])번 눌렸습니다.")
//        case .smile:
//            countArray[1] += 1
//            print("\(Emotion.smile) \(countArray[1])번 눌렸습니다.")
//        case .soso:
//            countArray[2] += 1
//            print("\(Emotion.soso) \(countArray[2])번 눌렸습니다.")
//        case .sad:
//            countArray[3] += 1
//            print("\(Emotion.sad) \(countArray[3])번 눌렸습니다.")
//        case .tear:
//            countArray[4] += 1
//            print("\(Emotion.tear) \(countArray[4])번 눌렸습니다.")
//        default:
//            break
//        }
        
    }
    
    
    
    
    
    
    @IBAction func pullDownButtonTapped(_ sender: UIButton) {
        
    }
    
    
    
    
    
  
    
    
    
    

    // Pull Down Button 설정
    @IBAction func oneTimeTapped(_ sender: UIMenuElement) {
        
    }
    
    
    
    
}

