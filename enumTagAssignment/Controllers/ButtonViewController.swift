//
//  ViewController.swift
//  enumTagAssignment
//
//  Created by Heedon on 2023/07/25.
//

import UIKit

class ButtonViewController: UIViewController {

//    var countArray = [0, 0, 0, 0, 0]
//    var emotions = Emotion.allCases
    
    @IBOutlet var pullDownButtons: [UIButton]!
    
    let dataManager = DataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configDataManager()
        configMenu()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataManager.saveData()
    }
    
    func configDataManager() {
        dataManager.retrieveData()
    }

    func configMenu() {
        
        //UIAction title button icon 옆에 안보이도록 하기?
        
        for button in pullDownButtons {
            button.tintColor = .black
            button.setTitleColor(.clear, for: .normal)      //UIButton Menu 옆 title 뜨는 것 방지
            
            let once = UIAction(title: "1회") { _ in
                self.dataManager.updateData(tag: button.tag)
            }
            let fiveTimes = UIAction(title: "5회") { _ in
                self.dataManager.updateDataFiveTimes(tag: button.tag)
            }
            let tenTimes = UIAction(title: "10회") { _ in
                self.dataManager.updateDataTenTimes(tag: button.tag)
            }
            let reset = UIAction(title: "Reset", attributes: .destructive) { _ in
                self.dataManager.resetData(tag: button.tag)
            }
            
            let buttonMenu = UIMenu(children: [once, fiveTimes, tenTimes, reset])
            button.menu = buttonMenu
        }
    }
    
    @IBAction func emojiButtonTapped(_ sender: UIButton) {
        
        dataManager.updateData(tag: sender.tag)
        
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
    
}

