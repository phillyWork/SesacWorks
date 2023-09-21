//
//  ViewController.swift
//  CodeModuleMVVM
//
//  Created by Heedon on 2023/09/19.
//

import UIKit
//import Alamofire
import SnapKit
import Kingfisher

class ViewController: UIViewController {

    //MARK: - Properties
    
    //network 통신 함수 모두 network 기능 singleton이 담당
    let networkBasic = NetworkBasic.shared
    
    //generic 활용 메서드 호출하기
//    let network = Network.shared
    
    //viewModel에서 처리하도록 만들기
    let viewModel = ViewModel()
    
    //imageView 확대, 축소: scrollView 내부 위치
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemGreen
        
        //최소 scale size: 1배수 == 더 축소해도 1배수로 돌아옴
        view.minimumZoomScale = 1
        
        //더 이상 확대되지 않는 지점
        view.maximumZoomScale = 4
        
        //indicator 숨기기
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        //delegate로 확대, 축소 기능 구현
        view.delegate = self
        
        return view
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .clear
        iv.contentMode = .scaleAspectFit
        
        //double tap gesture 인식 위함
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //호출 순서: view에 등록 후 위치 선정
        configureHierarchy()
        configureLayout()
        
        //gesture 기반 action 설정
        configureGesture()
        
        
        //viewModel 활용, URL 받아와서 image 할당하기
        //VC: 어떤 이미지, 어떤 url이 왔는지 몰라도 됨
        viewModel.request { url in
            self.imageView.kf.setImage(with: url)
        }
//        request()
        
        
//        callRequest(query: "sky")
//        callRandomReqeust()
//        callSingleRequest(id: "mfb_evGFm78")
        
        
//        networkBasic.callRequest(query: "sky") { response in
//            switch response {
//            case .success(let success):
//                print(success)
//            case .failure(let failure):
//                print(failure)
//            }
//        }
        

//        //completionHandler 대응: 2가지 매개변수 활용
//        networkBasic.callRandomReqeust { photo, error in
//            //optional binding으로 해제 필요: 둘 다 nil일 수 있음
//            //photo와 error 공존할 수 없음을 인지하고 작성해야 함
//
//            if let error {}             //error 존재 여부 확인
//        }

                
        //completionHandler 대응: Result type 활용
//        networkBasic.callSingleRequest(id: "mfb_evGFm78") { response in
//            //성공과 실패만 대응: switch (optional binding 처리 없음)
//            switch response {
//            //성공과 실패일 때의 각각의 data 전달
//            case .success(let success):
//                print("UI update or data 저장 등...")
//                print(success)
//            case .failure(let failure):
//                print("다시 시도해주세요 관련 alert")
//                print(failure)
//            }
//        }
        
        
            //UnsplashAPI enum 활용
//        //T를 명시적으로 나타내기
//        network.callRequest(type: Photo.self, api: .search(query: "apple")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//
//        //api case에 따른 type 연결도 가능
//        network.callRequest(type: PhotoResult.self, api: .random) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//
//        //random에서 얻은 id를 저장, 여기에 전달하기도 가능
//        network.callRequest(type: PhotoResult.self, api: .single(id: "mfb_evGFm78")) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
        
    }

    //viewModel로 이동
//    func request() {
//        //Router 활용: 구현부 달라지는 것은 없음
//        network.requestConvertible(type: PhotoResult.self, api: .random) { response in
//            switch response {
//            case .success(let success):
//                dump(success)
//
//                //link 활용해서 image 가져오기
//                self.imageView.kf.setImage(with: URL(string:success.urls.thumb)!)
//
//            case .failure(let failure):
//                print(failure.errorDescription)
//            }
//        }
//    }
    
    
    private func configureHierarchy() {
        view.addSubview(scrollView)
        
        //imageView 확대, 축소: scrollView 내부 존재
        scrollView.addSubview(imageView)
    }
    
    private func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.size.equalTo(200)
        }
        
        imageView.snp.makeConstraints { make in
            //scrollView size가 변경되고 처음에 딱 맞게 나타나도록
            make.size.equalTo(scrollView)
        }
        
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        
        //tap 횟수 요구
        tap.numberOfTapsRequired = 2
        
        imageView.addGestureRecognizer(tap)
    }
    
    @objc private func doubleTapGesture() {
        //zoomScale property 기반 처리
        if scrollView.zoomScale == 1 {
            //줌 인
            scrollView.setZoomScale(2, animated: true)
        } else {
            //원래 size로 돌아오기
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    
}

//MARK: - Extension for ScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    
    //zoom할 경우, 어떤 view를 보여줄 지 (어떤 view로 scrollView를 채울 지)
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        //scrollView 크기에 맞게 보여주기
        return imageView
    }
    
    
    
}
