//
//  ViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

import SesacFramework

//protocol Delegate 값 전달
//1. protocol 정의
protocol PassDataDelegate {
    func receiveDate(date: Date)
}

protocol ApplyImageDelegate {
    func receiveImage(image: UIImage)
}

//Naming Convention 관점에서 Main, Detail: 추상, 상징적 의미 --> 실제 기능, 목적으로 이름짓기

//매번 일일히 configViews와 setConstraints 정의하고 작성
//BaseVC 만들어서 거기에 작성, BaseVC 상속하기
class AddViewController: BaseViewController {

    //view 구성을 따로 AddView에서 구성 --> 코드 이동
//    let photoImageView = {
//        let view = UIImageView()
//        view.backgroundColor = .lightGray
//        view.contentMode = .scaleAspectFill
//        return view
//    }()
//
//    let searchButton = {
//        let button = UIButton()
//        button.backgroundColor = .systemGreen
//        return button
//    }()
    
    //AddView 자체를 instance로 가져오기
    let mainView = AddView()
    
    
    
    //imagePicker
    let imagePicker = UIImagePickerController()
    

    //rootView 준비되는 시점
    //viewDidLoad보다 먼저 호출
    //super 메서드 호출 X: super 메서드 호출 시 super class의 rootView 설정으로 적용됨
    override func loadView() {
        //바탕 view를 AddView instance로 교체
        self.view = mainView
    }
    
    override func viewDidLoad() {
        //super: BaseVC
        super.viewDidLoad()

//        APIService.shared.callRequest()
        
        //BaseVC의 viewDidLoad에서 이미 호출함
        //AddVC의 configViews와 setConstraints는 알아서 호출됨
        
//        configViews()
//        setConstraints()
        
        //searchButton 누르면 SearchVC 띄우기
        //AddView로 이동한 view의 addTarget: 해당 AddView의 property처럼 나타내기
        //viewDidLoad보다 configView로 코드 이동 (관련 action control로 기능 분리)
//        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
     
        
        //access control with module
        //open, public --> module 간 접근, 활용 가능 (module 단위)
        //internal, fileprivate, private --> module 내 접근, 활용 가능 (source file 단위)
//        ClassOpenExample.publicExample()
//        ClassOpenExample.interanalExample()
//        ClassPublicExample.publicExample()
//        ClassInternalExample.publicExample()
        
        
        imagePicker.delegate = self
        
    }
    
    
    //viewDidLoad는 한번만 수행
    //observer 여러번 등록해야 하는 상황
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            
        print(#function)
        //NotificationCenter에서 보낸 signal 받을 observer 등록하기
        //observer: VC가 observer 역할 --> self
        //name: 보낸 신호와 동일 이름, 신호 수신함
        //신호 받아서 할 일: selector에서 처리
//        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: NSNotification.Name("SelectImage"), object: nil)
        
        //NSNotification.Name extension 활용
        NotificationCenter.default.addObserver(self, selector: #selector(selectImageNotificationObserver), name: .selectImage, object: nil)
        
        //public 정의 --> 활용 가능
        sesacShowActivityViewController(image: UIImage(systemName: "star")!, url: "hello", text: "hi")
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
        
        //등록한 observer 제거하기 (여러번 중복 등록 방지 목적)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("SelectImage"), object: nil)
        
        //NSNotification.Name extension 활용
        NotificationCenter.default.removeObserver(self, name: .selectImage, object: nil)
    }
    
    //신호 수신한 경우 호출
    @objc func selectImageNotificationObserver(notification: NSNotification) {
        //userInfo 데이터 가져오기: 매개변수로 notification 받기
        
        //userInfo 내 key값이 다른/없는 경우, 해당 data 존재하지 않음
        //Optional로 처리
        print(notification.userInfo?["name"])
        print(notification.userInfo?["sample"])

        //Any type이므로 타입캐스팅 필요
        if let name = notification.userInfo?["name"] as? String {
            mainView.photoImageView.image = UIImage(systemName: name)
        }
        
    }
    

    override func configViews() {
        
        //부모 class의 내부 작성 코드 실행 원하면: 부모 class의 메서드 실행 필요
        super.configViews()
        
        print("AddVC configViews")
//        view.backgroundColor = .white
        
        //AddView에서 view 구성하기 --> 코드 이동
//        view.addSubview(photoImageView)
//        view.addSubview(searchButton)
        
        //해당 view property의 action 연결
        
        //addTarget을 view closure 수행 시 같이 활용 가능 --> view에서 viewController로 코드 전달 필요
        mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        mainView.searchProtocolButton.addTarget(self, action: #selector(searchProtocolButtonTapped), for: .touchUpInside)
        
        mainView.pickerButton.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
        
        mainView.titleButton.addTarget(self, action: #selector(titleButtonTapped), for: .touchUpInside)
        
        mainView.subTitleButton.addTarget(self, action: #selector(subTitleButtonTapped), for: .touchUpInside)
    }
    
    override func setConstraints() {
        
        super.setConstraints()
        
        print("AddVC setConstraints")
        
        //AddVC 말고 AddView에서 View 구성 및 설정: 코드 이동하기
//        photoImageView.snp.makeConstraints { make in
//
//            //기본 margin 8 설정 유무 차이
////            make.topMargin.leadingMargin.trailingMargin.equalTo(view.safeAreaLayoutGuide).inset(10)
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(2)        //10-8
//            make.height.equalTo(view).multipliedBy(0.3)
//        }
//
//        searchButton.snp.makeConstraints { make in
//            make.size.equalTo(50)
//            make.bottom.trailing.equalTo(photoImageView)
//        }

    }
    
    
    
    func setActionSheet() {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default) { _ in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                print("Can't get access to gallery")
                return
            }
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true)
        }
        let web = UIAlertAction(title: "웹에서 검색하기", style: .default) { _ in
            self.navigationController?.pushViewController(SearchViewController(), animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        sheet.addAction(gallery)
        sheet.addAction(web)
        sheet.addAction(cancel)
        present(sheet, animated: true)
    }
    
    //MARK: - Handlers
    
    @objc func searchButtonTapped() {
        
        let wordList = ["Apple", "Banana", "Cookie", "Sky"]
        
        //Notification으로 SearchVC에 값 전달하기: 정방향 VC는 전달되지 않음
        //observer가 생성될 시점에 이미 post 호출
        //observer는 받을 수 없음
        
        //present가 먼저 되어서 SearchVC가 메모리에 load되고 post보내도 항상 그렇다고 장담 못함
        //해당 VC가 얼마나 오래 load되어야 하는지 알 수 없음
        //post가 먼저 수행될 수 있음
        NotificationCenter.default.post(name: NSNotification.Name("RecommendKeyword"), object: nil, userInfo: ["word": wordList.randomElement()!])
        
//        present(SearchViewController(), animated: true)
        
        //viewWillAppear 여러번 띄우는 상황
        //sceneDelegate에서 nav로 시작
        //push로 화면 여러번 띄우기
//        navigationController?.pushViewController(SearchViewController(), animated: true)
        
        setActionSheet()
    }
    
    @objc func searchProtocolButtonTapped() {
        //push 대신 present로 SearchVC 띄우기
        let searchVC = SearchViewController()
        searchVC.delegate = self
        present(searchVC, animated: true)
    }
    
    @objc func pickerButtonTapped() {
        //pickerView에서 선택한 날짜를 button title로 적용하기
        
        //protocol Delegate 값 전달
        //4. protocol의 소유자의 delegate 필수 함수를 실제 수행할 대상 설정
        let vc = DatePickerViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //titleButtonTapped: 호출되는 순간 코드 수행하고 끝남
    //back button으로 되돌아오는 경우: 그제서야 completionHandler 뒤늦게 실행
    @objc func titleButtonTapped() {
        let vc = TitleViewController()
        
        //closure로 값 전달하기
        //3. completionHandler에 실제 함수 전달하기
        //closure 활용 ~ 매개변수 활용
        vc.completionHandler = { result in
            //어떤 일을 할지 미리 구현
            self.mainView.titleButton.setTitle(result, for: .normal)
            print("completionHandler")
        }
        
        //여러 데이터 전달: data type을 먼저 확인하기
        vc.completionHandlerVariousTypes = { title, age, push in
            self.mainView.titleButton.setTitle(title, for: .normal)
            print("various type data for completionHandler", age, push)
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    

    @objc func subTitleButtonTapped() {
        let subTitleVC = SubTitleViewController()
        subTitleVC.completionHandler = { result in
            self.mainView.subTitleButton.setTitle(result, for: .normal)
            print("subtitle completionHandler finish!")
        }
        navigationController?.pushViewController(subTitleVC, animated: true)
    }
    
}


//MARK: - Extension for ImagePickerDelegate, NavigationControllerDelegate

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //해당 이미지 탭
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            mainView.photoImageView.image = image
            dismiss(animated: true)
        }
    }
    
    //취소 버튼
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
}



//MARK: - Extension for PassDataDelegate

extension AddViewController: PassDataDelegate {
    
    //protocol Delegate 값 전달
    //5. protocol의 필수 함수 실제 구현 내용 작성
    func receiveDate(date: Date) {
//        mainView.pickerButton.setTitle("\(date)", for: .normal)
        mainView.pickerButton.setTitle(DateFormatter.convertDate(date: date), for: .normal)
    }
}


//MARK: - Extension for ApplyImageDelegate

extension AddViewController: ApplyImageDelegate {
    
    func receiveImage(image: UIImage) {
        mainView.photoImageView.image = image
    }

}
