//
//  GCDBasicViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class GCDBasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
 
//        serialSync()
//        serialAsync()
//        concurrentSync()
        concurrentAsync()
//        concurrentAsyncTwo()
    }

    func concurrentAsyncTwo() {
        print("Start")
        
        for i in 1...100 {
            DispatchQueue.global().async {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    func concurrentAsync() {
        print("Start")
        //네트워킹 및 오래 걸리는 작업 처리 (background thread로 처리)
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                print("It's about to show alertController for main async inside global async")
                self.makeAlert(title: "main queue에서 시작", message: "serial async 시작")
            }
            
            
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        print("It's about to show alertController for main sync")
        self.makeAlert(title: "main queue에서 시작", message: "serial 시작")
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    func concurrentSync() {
        print("Start")
        
        DispatchQueue.global().sync {
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
        
        
    }
    
    
    func serialAsync() {
        print("Start")
        
        DispatchQueue.main.async {
            for i in 1...50 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
        
        for i in 51...100 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        print("End")
    }
    
    
    
    func serialSync() {
        print("Start")
        
        for i in 1...50 {
            sleep(1)
            print(i, terminator: " ")
        }
        
        //main thread, sync 요청
        //Error 발생: 무한 대기 상태, deadlock 교착 상태
        DispatchQueue.main.sync {
            for i in 51...100 {
                sleep(1)
                print(i, terminator: " ")
            }
        }
       
        print("End")
    }

    
    func makeAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel) { action in
            print("Confirm Button Tapped")
        }
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
}
