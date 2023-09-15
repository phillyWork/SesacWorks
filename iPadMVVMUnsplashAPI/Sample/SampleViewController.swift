//
//  SampleViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

import UIKit

//유저 정보
struct User {
    let name: String
    let age: Int
    
    //연산 프로퍼티로 data 가공 나타내기
    //호출될 때 메모리 올라옴
    var intorduce: String {
        return "\(name), \(age)살"
    }
    
}

class SampleViewController: UIViewController {
    
    //view 역할
    @IBOutlet weak var tableView: UITableView!
    
    //data: ViewModel이 보유 (VC가 굳이 data 가지고 있을 필요 없음)
//    var list = [User(name: "Hue", age: 23), User(name: "Jack", age: 21), User(name: "Bran", age: 20), User(name: "Kokojong", age: 20)]

    //ViewModel instance 필요
    let viewModel = SampleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //순서대로 동작하는 경우
        var number1 = 10
        var number2 = 3
        
        print(number1 - number2)
        
        //변경되었을 때 다시 print 호출되지 않음
        number1 = 3
        number2 = 1

        
        //Observable 활용하는 경우
        //양방향 binding
        
        var number3 = Observable(10)
        var number4 = Observable(3)
        
        //연결해 놓음: model data 변경마다 해당 logic 수행
        number3.bind { number in
            print("Observable", number3.value - number4.value)
        }
        
        //값이 바뀔 때마다 ViewModel에 알림, 해당 logic 수행
        number3.value = 100
        number3.value = 500
        number3.value = 50
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    

    
}

extension SampleViewController: UITableViewDelegate, UITableViewDataSource {
    
    //VC가 view에게 데이터 전달
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return list.count
        
        //ViewModel이 갖고 있는 기능으로 호출 (코드 분리)
        return viewModel.numberOfRowsInSection
        
    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "sampleCell")!
//
////        let data = list[indexPath.row]
//        //viewModel function으로 대체
//        let data = viewModel.cellForRowAt(at: indexPath)
//
//        //data 연산/가공으로 적용
////        cell.textLabel?.text = "\(data.name), \(data.age)살"
//
//        //model의 연산 property로 적용
//        //VC가 가공까지 하지 않기 (view에게 data 전달만 하기), 모델에서 처리하도록 하기
//        cell.textLabel?.text = data.intorduce
//
//        return cell
//    }

    
    //UIListContentConfiguration 활용
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        var content = cell.defaultContentConfiguration()
        content.text = "테스트"                                    //textLabel
        content.secondaryText = "안녕하세요 \(indexPath.row)"       //detailTextLabel
        
        cell.contentConfiguration = content                     //protocol as type
                
        //UIListContentConfiguration: UIContentConfiguration protocol 채택
        
        return cell
    }
    
    
    
    
}


