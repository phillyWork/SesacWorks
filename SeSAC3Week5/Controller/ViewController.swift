//
//  ViewController.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var syncButton: UIButton!
    @IBOutlet var asyncButton: UIButton!
    @IBOutlet var groupButton: UIButton!
     
    @IBOutlet var firstImageView: UIImageView!
    @IBOutlet var secondImageView: UIImageView!
    @IBOutlet var thirdImageView: UIImageView!
    @IBOutlet var fourthImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        syncButton.addTarget(self, action: #selector(syncButtonClicked), for: .touchUpInside)
        asyncButton.addTarget(self, action: #selector(asyncButtonTaped), for: .touchUpInside)
    }
        
    
    //MARK: - Sync
    
    @objc func syncButtonClicked() {
        
        print("sync start")
        downloadImage(imageView: firstImageView, value: "first")
        downloadImage(imageView: secondImageView, value: "second")
        downloadImage(imageView: thirdImageView, value: "third")
        downloadImage(imageView: fourthImageView, value: "fourth")
        print("sync end")       //동기, 순서대로 실행, 끝나는 지점 알 수 있음 (시간은 오래 걸릴 수 밖에 없음)
        
    }
    
    func downloadImage(imageView: UIImageView, value: String) {
         
        print("===1===\(value)===")
        let data = try! Data(contentsOf: Nasa.photo)
        imageView.image = UIImage(data: data)
        print("===2===\(value)===")
        
    }

    
//MARK: - Async
    
    @objc func asyncButtonTaped() {
        print("async start")
        asyncDownloadImage(imageView: firstImageView, value: "first")
        asyncDownloadImage(imageView: secondImageView, value: "second")
        asyncDownloadImage(imageView: thirdImageView, value: "third")
        asyncDownloadImage(imageView: fourthImageView, value: "fourth")
        print("async end")
    }

    
    //다른 thread에게 작업을 보내고 나머지 코드 실행 (작업 결과, 진행 상황 관심 없음)
    //작업이 언제 끝날 지 정확한 시점 알기 어려움
    //UI 관련 작업은 main thread에서 수행해야 함
    func asyncDownloadImage(imageView: UIImageView, value: String) {
        //Thread.isMainThread: main thread에서 작업 되는 중인지 확인
        print("===1===\(value)===", Thread.isMainThread)
        //url로 data 가져와 Data 변형: 오래 걸리는 task
        //global queue로 background thread 활용
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                print("It's about to show alertController for main async inside global async")
                self.makeAlert(title: "global queue에서 시작", message: "main queue에서 present")
            }
            
            print("===2-1===\(value)===", Thread.isMainThread)
            let data = try! Data(contentsOf: Nasa.photo)
            //가져온 데이터로 이미지 적용: global().async 안에 존재해야 함
            //이미지로 UI update: main thread에서 처리
            DispatchQueue.main.async {
                print("It's about to show alertController for main async")
                self.makeAlert(title: "main queue에서 시작", message: "serial async 시작")
                
                print("===2-2===\(value)===", Thread.isMainThread)
                imageView.image = UIImage(data: data)
            }
            print("===2-3===\(value)===", Thread.isMainThread)
        }
        
        //global thread에 맡겨 놓은 결과 신경쓰지 않음
        //바로 다음 코드로 넘어와 수행
        print("===3===\(value)===", Thread.isMainThread)
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

