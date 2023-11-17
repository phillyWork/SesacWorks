//
//  PhotoViewController.swift
//  iPadMVVMUnsplashAPI
//
//  Created by Heedon on 2023/09/12.
//

import UIKit

class PhotoTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //ViewModel instance 만들기
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //네트워크 통신 진행 --> data 변경 --> bind 호출
        viewModel.fetchPhoto(text: "sky")
        
        //Observable: data 변경 시 해줄 작업 closure로 구현
        viewModel.list.bind { _ in
            //data가 변경: UI update
            
            //viewModel의 fetchPhoto: URLSession 활용 --> background thread로 처리 (VC는 이 내용도 알지 못함, 관심없음)
            //UI update: main thread에서 처리해야 함

            //viewModel에서 main 호출 or
            //viewController에서 main 호출
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
}

extension PhotoTableViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //VC는 내부 로직 몰라도 데이터만 가져다 활용하기
        return viewModel.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell")!

        //VC는 내부 로직 몰라도 data만 가져다 활용하기
        let data = viewModel.cellForRowAt(at: indexPath)

//        if data != nil {
//            cell.backgroundColor = .lightGray
//        } else {
//            cell.backgroundColor = .brown
//        }

        //optional 대응 필요 없으므로 바로 할당 가능
        cell.backgroundColor = .lightGray

        //UIImage 받아다가 바로 cell에 나타내기
        viewModel.getPhotoWithURL(indexPath: indexPath) { image in
            print("Getting image success!", image)
            cell.imageView?.image = image
        }

        return cell
    }

}
