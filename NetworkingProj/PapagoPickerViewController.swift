//
//  PapagoPickerViewController.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

enum TargetLangCode: String, CaseIterable {
    case ko = "ko"
    case en = "en"
    case ja = "ja"
    case zhCN = "zh-CN"
    case zhTW = "zh-TW"
    case vi = "vi"
    case id = "id"
    case th = "th"
    case de = "de"
    case ru = "ru"
    case es = "es"
    case it = "it"
    case fr = "fr"
    
    var langInKor: String {
        switch self {
        case .ko:
            return "한국어"
        case .en:
            return "영어"
        case .ja:
            return "일본어"
        case .zhCN:
            return "중국어 간체"
        case .zhTW:
            return "중국어 번체"
        case .vi:
            return "베트남어"
        case .id:
            return "인도네시아어"
        case .th:
            return "태국어"
        case .de:
            return "독일어"
        case .ru:
            return "러시아어"
        case .es:
            return "스페인어"
        case .it:
            return "이탈리아어"
        case .fr:
            return "프랑스어"
        }
    }
    
    var koTarget: [String] {
        var result : [String] = []
        for lang in TargetLangCode.allCases {
            if lang.rawValue == "ko" {
                continue
            }
            result.append(lang.rawValue)
        }
        return result
    }
    
    var enTarget: [String] {
        return [TargetLangCode.ja.rawValue, TargetLangCode.fr.rawValue, TargetLangCode.zhCN.rawValue, TargetLangCode.zhTW.rawValue, TargetLangCode.ko.rawValue]
    }

    var jaTarget: [String] {
        return [TargetLangCode.zhCN.rawValue, TargetLangCode.zhTW.rawValue, TargetLangCode.ko.rawValue, TargetLangCode.en.rawValue]
    }
    
    var zhCNTarget: [String] {
        return [TargetLangCode.zhTW.rawValue, TargetLangCode.ko.rawValue, TargetLangCode.en.rawValue, TargetLangCode.ja.rawValue]
    }
    
    var zhTWTarget: [String] {
        return [TargetLangCode.ko.rawValue, TargetLangCode.en.rawValue, TargetLangCode.ja.rawValue, TargetLangCode.zhCN.rawValue]
    }
    
    var frTarget: [String] {
        return [TargetLangCode.en.rawValue, TargetLangCode.ko.rawValue]
    }
    
    var viIdThDeRuEsItTarget : [String] {
        return [TargetLangCode.ko.rawValue]
    }
    
}

class PapagoPickerViewController: UIViewController {

    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var originalLabel: UILabel!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let langCode = ["ko", "en", "ja", "zh-CN", "zh-TW", "vi", "id", "th", "de", "ru", "es", "it", "fr"]
    
    var originalCode: String?
    var targetCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        originalTextView.delegate = self
        
        originalTextView.text = "번역할 텍스트를 입력해주세요."
        originalTextView.textColor = .darkGray
        
        originalLabel.text = ""
        originalLabel.textAlignment = .center
        originalLabel.textColor = .black
        
        targetLabel.text = ""
        targetLabel.textAlignment = .center
        targetLabel.textColor = .black
        
        targetTextView.textColor = .black
        targetTextView.text = ""
        
        translateButton.setTitle("번역하기", for: .normal)
        translateButton.setTitleColor(.white, for: .normal)
        translateButton.backgroundColor = .black
        
        indicatorView.isHidden = true
    }
    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        guard let originalSource = originalCode else {
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            targetTextView.textColor = .black
            targetTextView.text = "원어를 선택해주세요."
            return
        }
        
        guard let targetSource = targetCode else {
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            targetTextView.textColor = .black
            targetTextView.text = "번역하려는 언어를 선택해주세요."
            return
        }
        
        guard let type = TargetLangCode(rawValue: originalSource) else {
            print("No type at all")
            return
        }
        
        let noConnection = "해당 번역 서비스는 제공하지 않습니다."
        switch type {
        case .ko:
            if !type.koTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        case .en:
            if !type.enTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        case .ja:
            if !type.jaTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        case .zhCN:
            if !type.zhCNTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        case .zhTW:
            if !type.zhTWTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        case .fr:
            if !type.frTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        default:
            if !type.viIdThDeRuEsItTarget.contains(targetSource) {
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                targetTextView.textColor = .black
                targetTextView.text = noConnection
                return
            }
        }
        
        guard let inputText = originalTextView.text else {
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            targetTextView.textColor = .black
            targetTextView.text = "번역을 위해 입력을 해주세요."
            return
        }
        
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        
        let parameters: Parameters = [
            "source": originalSource,
            "target": targetSource,
            "text": inputText
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let json = JSON(value)
                
                print("json: \(json)")
                
                var result = json["message"]["result"]["translatedText"]
                var resultString = result.stringValue
            
//                print("result: \(result) and resultString: \(resultString)")
            
                if resultString.isEmpty {
                    result = "번역을 할 수 없습니다."
                }
                    
                self.indicatorView.stopAnimating()
                self.indicatorView.isHidden = true
                
                self.targetTextView.text = resultString
                
            case .failure(let error):
                print("Error: ", error.localizedDescription)
            }
        }
        
    }
    
}


extension PapagoPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TargetLangCode(rawValue: langCode[row])?.langInKor
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            originalLabel.text = "원어: \(TargetLangCode(rawValue: langCode[row])!.langInKor)"
            originalCode = langCode[row]
        } else if component == 1 {
            targetLabel.text = "번역 언어: \(TargetLangCode(rawValue: langCode[row])!.langInKor)"
            targetCode = langCode[row]
        }
    }
    
    
}

extension PapagoPickerViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "번역할 텍스트를 입력해주세요."
            textView.textColor = .darkGray
        }
    }
}
