//
//  NewWordViewController.swift
//  BoardAndNewWord
//
//  Created by Heedon on 2023/07/24.
//

import UIKit

class NewWordViewController: UIViewController {
    
    //MARK: - Properties
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var wordButtons: [UIButton]!

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var meaningLabel: UILabel!

    let words: [String: String] = ["알잘딱깔센": "알아서 잘 딱 깔끔하고 센스있게", "H워월V": "사랑해", "핑프": "핑거 프린세스", "다꾸": "다이어리 꾸미기", "인만추": "인공적인 만남 추구", "스불재": "스스로 불러온 재앙", "킹리적갓심": "매우 합리적 의심", "700": "귀여워", "무물": "무엇이든 물어보세요", "갑통알": "갑자기 통장 보니 알바해야겠다"]
    
//    var notUsedWords : [String: String] = ["알잘딱깔센": "알아서 잘 딱 깔끔하고 센스있게", "H워월V": "사랑해", "핑프": "핑거 프린세스", "다꾸": "다이어리 꾸미기", "인만추": "인공적인 만남 추구", "스불재": "스스로 불러온 재앙", "킹리적갓심": "매우 합리적 의심", "700": "귀여워", "무물": "무엇이든 물어보세요", "갑통알": "갑자기 통장 보니 알바해야겠다"]
//    var usedWordsForWordButtons : [String: String] = [:]
    
    var setOfNotUsedWordsKeys: Set<String> = []
    var setOfUsedWordsKeys: Set<String> = []
    
    //MARK: - Setup UI
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setOfNotUsedWordsKeys = Set(words.keys)
        
        configUI()
    }
    
    func configUI() {
        configUserTextField()
        configButtons()
        configImageView()
        configMeaningLabel()
    }
    
    func configUserTextField() {
        userTextField.borderStyle = .line
        userTextField.tintColor = .black
        userTextField.placeholder = "신조어를 입력해보세요"
    }
    
    func configButtons() {
        configSearchButton()
        configWordButtons()
    }
    
    func configSearchButton() {
        searchButton.backgroundColor = .black
        searchButton.tintColor = .white
    }
    
    func configWordButtons() {
        
        for button in wordButtons {
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 10)
            button.backgroundColor = .white
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 2
            
            //button에 추천 단어 랜덤으로 제공
            //Array: randomElement() ~ O(1) for conforming RandomAccessCollection
            if let word = Array(words.keys).randomElement() {
                if setOfUsedWordsKeys.contains(word) {
                    if let newWord = setOfNotUsedWordsKeys.randomElement() {
                        button.setTitle(newWord, for: .normal)
                        setOfNotUsedWordsKeys.remove(newWord)
                        setOfUsedWordsKeys.insert(newWord)
                    }
                } else {
                    button.setTitle(word, for: .normal)
                    setOfNotUsedWordsKeys.remove(word)
                    setOfUsedWordsKeys.insert(word)
                }
            }
            
            //set으로 한번에 관리 시, 버튼 간 중복 여부 판단 어려움
//            if let word = Array(notUsedWords.keys).randomElement(), let meaning = notUsedWords[word] {
//                button.setTitle(word, for: .normal)
//                notUsedWords.removeValue(forKey: word)
//                usedWordsForWordButtons[word] = meaning
//            }
        }
    }
    
    func configImageView() {
//        imageView.image = UIImage(named: "background")
        imageView.image = UIImage(named: "browser")
        imageView.backgroundColor = .clear
    }
    
    func configMeaningLabel() {
        meaningLabel.textColor = .black
        meaningLabel.text = "신조어를 입력해보세요"
        meaningLabel.textAlignment = .center
        meaningLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        meaningLabel.numberOfLines = 0
    }
    
    
    //MARK: - API
    
    func createAlertForConfirmation(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirm = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(confirm)
        present(alert, animated: true)
    }
    
    func meaningOfWordIsValidInData(word: String) -> String? {
        //Set: contains ~ O(1)
        
        return setOfNotUsedWordsKeys.contains(word) || setOfUsedWordsKeys.contains(word) ? words[word] : nil
        
//        if setOfNotUsedWordsKeys.contains(word) {
//            return notUsedWords[word]
//        } else if setOfUsedWordsKeys.contains(word) {
//            return usedWordsForWordButtons[word]
//        } else {
//            return nil
//        }
    }
    
    //단어 존재 후 검색할 예정
    //true: 버튼 누른 것, false: 버튼 누른 것 아님
    func checkWordIsInUsed(word: String) -> Bool {
        return setOfUsedWordsKeys.contains(word) ? true : false
    }
    
    @IBAction func textFieldEnterKeyTapped(_ sender: UITextField) {
        searchButtonTapped(searchButton)
    }
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        if userTextField.hasText, let text = userTextField.text, text.count >= 2 {
            //입력값 있으므로 검색하기
            if let meaning = meaningOfWordIsValidInData(word: text) {
                //입력값 존재
                meaningLabel.text = meaning
                
                if checkWordIsInUsed(word: text) { //버튼에서 검색
                    //used 비우기 (어차피 찾은 단어와 의미는 지역변수로 가지고 있음)
                    
                    for key in setOfUsedWordsKeys {
                        setOfNotUsedWordsKeys.insert(key)
                    }
                    setOfUsedWordsKeys.removeAll()
                    
//                    for (key, value) in usedWordsForWordButtons {
//                        notUsedWords[key] = value
//                        usedWordsForWordButtons.removeValue(forKey: key)
//                    }
                    
                    
                    //used 새로 채우기
                    //label로 나타난 단어와 의미 제외 새로운 4개 넣기
                    for button in wordButtons {
                        if let newWord = Array(words.keys).randomElement() {
                            if meaning == words[newWord] || setOfUsedWordsKeys.contains(newWord) {
                                if let secondNewWord = setOfNotUsedWordsKeys.randomElement() {
                                    button.setTitle(secondNewWord, for: .normal)
                                    setOfNotUsedWordsKeys.remove(secondNewWord)
                                    setOfUsedWordsKeys.insert(secondNewWord)
                                }
                            } else {
                                button.setTitle(newWord, for: .normal)
                                setOfNotUsedWordsKeys.remove(newWord)
                                setOfUsedWordsKeys.insert(newWord)
                            }
                        }
                    }
                    
//                    for button in wordButtons {
//                        if let newWord = Array(notUsedWords.keys).randomElement(), let newMeaning = notUsedWords[newWord] {
//                            if meaning == newMeaning {
//                                continue
//                            }
//                            button.setTitle(newWord, for: .normal)
//                            notUsedWords.removeValue(forKey: newWord)
//                            usedWordsForWordButtons[newWord] = newMeaning
//                        }
//                    }
                    
                    
                }       //버튼에서 검색 아니면 그대로 두기
            } else {
                //입력값 존재하지 않음 alert 띄우기
                createAlertForConfirmation(title: "데이터 없음", message: "찾는 용어가 없습니다. 다시 입력해주세요.", actionTitle: "확인")
            }
        } else {
            //입력값 조건 맞지 않다면 해당 alert 띄우기
            createAlertForConfirmation(title: "입력 오류", message: "텍스트를 두 글자 이상 입력해야 입력값이 나타납니다.", actionTitle: "확인")
        }
    }
    
    //추천 단어 버튼 탭한 경우
    @IBAction func wordButtonTapped(_ sender: UIButton) {
        userTextField.text = sender.currentTitle
        textFieldEnterKeyTapped(userTextField)
    }
    
    
    @IBAction func areaTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
}

