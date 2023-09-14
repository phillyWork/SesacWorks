//
//  AsyncViewController.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/11.
//

import UIKit

class AsyncViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var thirdImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstImageView.backgroundColor = .black
        
        //view 그려지는 시점 다름: device 마다 원이 달라짐
        //비율 레이아웃 --> 너비 판단, 거기에 맞춰서 size 전해짐
        //frame의 width: storyboard 기준으로 먼저 잡힘
        
        
        print("1")

        //해결: main thread에서 처리
        DispatchQueue.main.async {
            print("2")
            self.firstImageView.layer.cornerRadius = self.firstImageView.frame.width / 2
        }
        
        print("3")
    }
    
    
    
    //키워드: sync async serial concurrent
    @IBAction func buttonTapped(_ sender: UIButton) {
        //KingFisher library 사용하지 않는다고 하면...
        
        //link 가져오기 --> 네트워크 통신, data 가져오기 --> 이미지 나타내기
        //동기 처리: data 가져오는 동안 아무것도 못함
        
        //비동기로 동시 처리하도록 함 (main thread는 UI 담당하도록, 이외의 thread에 작업 하도록 함)
        //이미지 보여주기는 이미지 데이터가 있어야 가능하므로 이 작업까지 같이 맡김
        
        //이미지를 보여주는 작업: UI interaction 및 update 작업 --> main thread에서만 처리해야 함
        //main thread에게 비동기로 시키기
        
        //이미지 보여주기 이외 다른 작업 필요하다면 global로 계속 처리하도록 맡김, 그 후에 main thread에서 비동기로 처리
        
        
        
        //url에서 Data 가져오기
        let url = URL(string: "https://api.nasa.gov/assets/img/general/apod.jpg")!
        
        
        //이미지 데이터 가져오는 작업: 시간 오래걸림
        //작업 완료될 때까지 UI interaction 포함 이후 코드 작업 이뤄지지 않음
        
        //globalQueue로 보내서 비동기로 처리하도록 함: 다른 thread에서 처리하도록 함
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            //data: Data type
            
            DispatchQueue.main.async {
                print("main thread working!!!")
                self.firstImageView.image = UIImage(data: data)
                print("It's main thread work done")
            }
            
            print("It's global thread work!!!")
        }
        
        //KingFisher 내부에 알아서 이미지 다운로드를 비동기로 처리하도록 함
        //image 세팅은 main thread에서 하도록 코드가 녹아있음
    
        
        
    }
    
    
    
    

    
}
