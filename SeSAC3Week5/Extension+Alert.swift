//
//  Extension.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/17.
//

import UIKit

//alert 기능 부여
extension UIViewController {
    //@escaping: showAlert 종료 이후에 실행됨 의미
    func showAlert(title: String, message: String, button: String, completionHandler: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let button = UIAlertAction(title: button, style: .default) { action in
            //호출 순서 2.
            print("Button Tap:", action.title)
            
            //내부 함수 실행 --> 외부의 요소 가져다 못 씀
            //내부에서 동작할 수 있는 기능을 외부에서 활용할 수 있도록 꺼내기:
            
            //completionHandler 실행
            completionHandler()
        }
        let cancel  = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(button)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
}

