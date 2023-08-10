//
//  TranslationViewController.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/10.
//

import UIKit
import Alamofire
import SwiftyJSON

//언어감지 --> papago 번역

class TranslationViewController: UIViewController {

    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var targetTextView: UITextView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    let cannotTranslateToEnglishList = ["hi", "en", "es", "de", "pt", "vi", "id", "fa", "ar", "mm", "th", "ru", "it", "unk"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        originalTextView.delegate = self
        targetTextView.delegate = self
        
        originalTextView.text = "영어로 번역하고 싶은 글을 입력해주세요."
        originalTextView.textColor = .darkGray
        targetTextView.text = ""
        targetTextView.isEditable = false
        
        translateButton.setTitle("번역 버튼", for: .normal)
        translateButton.setTitleColor(.white, for: .normal)
        translateButton.backgroundColor = .black
        
        indicatorView.isHidden = true
    }

    
    @IBAction func translateButtonTapped(_ sender: UIButton) {
        
        let langRecUrl = "https://openapi.naver.com/v1/papago/detectLangs"
        let translateUrl = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientID,
            "X-Naver-Client-Secret": APIKey.naverClientSecret
        ]
        
        let inputText = originalTextView.text ?? ""
        guard let searchText = inputText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("Can't encode text!")
            return
        }
                
        let langRecParameters: Parameters = ["query": searchText]
                
        indicatorView.startAnimating()
        indicatorView.isHidden = false
        
        AF.request(langRecUrl, method: .post, parameters: langRecParameters, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                
                let originalCode = JSON(value)["langCode"].stringValue
                
                print("originalCode: ", originalCode)
                
                //pickerView 같이 활용: 번역할 언어 선택도 가능하도록 할 수 있음
                
                if self.cannotTranslateToEnglishList.contains(originalCode) {
                    self.indicatorView.stopAnimating()
                    self.indicatorView.isHidden = true
                    self.targetTextView.text = "힌디어, 영어, 스페인어, 독일어, 포르투갈어, 베트남어, 인도네시아어, 페르시아어, 아랍어, 태국어, 러시아어, 이탈리어는 영어로 번역할 수 없습니다."
                    return
                }
                
                let parameters: Parameters = [
                    "source": originalCode,
                    "target": "en",
                    "text": self.originalTextView.text ?? ""
                ]
                
                AF.request(translateUrl, method: .post, parameters: parameters, headers: headers).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        
                        var result = JSON(value)["message"]["result"]["trasnlatedText"].stringValue
                        
                        print("result: ", result)
                    
                        if result.isEmpty {
                            result = "번역을 할 수 없습니다."
                        }
                            
                        self.indicatorView.stopAnimating()
                        self.indicatorView.isHidden = true
                        
                        self.targetTextView.text = result
                        
                    case .failure(let error):
                        print("Error: ", error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension TranslationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
        
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "번역하고 싶은 글을 입력해주세요."
            textView.textColor = .darkGray
        }
    }
}
