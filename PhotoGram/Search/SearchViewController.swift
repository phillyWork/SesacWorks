//
//  SearchViewController.swift
//  PhotoGram
//
//  Created by Heedon on 2023/08/28.
//

import UIKit

class SearchViewController: BaseViewController {

    //SearchView에서 view 생성, 등록, 관리
    
    //SearchView에서 등록 --> 코드 이동
//    let searchBar = {
//        let bar = UISearchBar()
//        bar.placeholder = "검색어를 입력해주세요"
//        return bar
//    }()
    
    
    //delegate
    var delegate: ApplyImageDelegate?
    
    
    //rootView 역할을 할 SearchView instance
    let mainView = SearchView()
    
    
    //collectionView에서 이미지 탭: AddVC에서 선택한 이미지 띄우기
    //API 대신 system Image 일단 활용
    let imageList = ["pencil", "person", "star.fill", "xmark", "person.circle"]
    
    var splashImageList = [String]()
    
    //rootView 교체
    override func loadView() {
        super.view = mainView
    }
    
    
    //호출할 필요 없더라도 view lifecycle 때문에 표시는 해두기
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AddVC로 부터 오는 notification 수신하기
        NotificationCenter.default.addObserver(self, selector: #selector(recommendKeywordNotificationObserver), name: NSNotification.Name("RecommendKeyword"), object: nil)
    
        //SearchVC로 오는 유저: 검색 목적 분명
        //굳이 searchBar를 눌러야 그때 keyboard 띄우지 않고
        //화면 뜨면 searchBar가 가장 먼저 유저 반응에 대응하는 responder로 만들기
        //--> 화면 뜨면 바로 keyboard 올라옴
        mainView.searchBar.becomeFirstResponder()
        mainView.searchBar.delegate = self
        
        splashAPI(keyword: "sky")
    }
    
    //post 수신 시 처리해야 할 일
    
    //동작하지 않음: 정방향 ~ addObserver보다 post가 먼저 신호보내는 경우
    //addObserver가 먼저 등록되어 있어야 함
    @objc func recommendKeywordNotificationObserver(notificaiton: NSNotification) {
        print("Recommend Keyword Notification Observer")
    }
    
    
    //SearchView에서 이미 view 구성, constraints 설정 완료
    //특별한 구성 없다면 굳이 VC에서 따로 더 설정할 필요 없음
    
    override func configViews() {
        super.configViews()
//        view.addSubview(searchBar)
        
        //collectionView의 protocol 연결
        //SearchView 내에서 설정: delegate 대리자가 VC가 되어야 하므로 불가
        //VC에서 설정: mainView의 property로 collectionView 접근하기
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
    }
    
    override func setConstraints() {
        super.setConstraints()
//        searchBar.snp.makeConstraints { make in
//            make.top.horizontalEdges.equalToSuperview()
//        }
    }

    func splashAPI(keyword: String) {
        print(#function)
        
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(keyword)&client_id=\(APIKey.accessKey)")
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("Session data finished")
            guard error == nil else {
                print("Error occurred: ", error?.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("No data at all")
                return
            }
            
            guard let jsonToArray = try? JSONSerialization.jsonObject(with: data) else {
                print("json to Any Error")
                return
            }
            
            print(jsonToArray)
            
            print("Done with session")
            
        }.resume()
    }
    
}


//MARK: - Extension for SearchBar Delegate

extension SearchViewController: UISearchBarDelegate {
    
    //검색 버튼 누른 경우: 키보드 내리기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //firstResponder로 등록한 경우, return 버튼 누르면 다시 firstResponder에서 해제하기
        mainView.searchBar.resignFirstResponder()
    }
    
}


//MARK: - Extension for CollectionView Delegate & DataSource

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .systemBrown
        
        cell.imageView.image = UIImage(systemName: imageList[indexPath.item])
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //해당 이미지 탭: 이전 화면에 이미지 적용하기
        
        //notification에서 전달하기
        //User Notification: 알림 종류, 앱 외부로 작동
        //알림의 종류, 앱 내부적으로 작동
        
        //신호와 더불어 값을 같이 전달
        //name: Notification 타입 설정 with key
        //object: 주체 ~ 대부분 nil
        //userInfo: 전달하려는 값, key-value로 전달
        NotificationCenter.default.post(name: NSNotification.Name("SelectImage"), object: nil, userInfo: ["name": imageList[indexPath.item], "sample": "고래밥"])
        
        //push로 온 경우 화면 사라지게 하기
//        navigationController?.popViewController(animated: true)
    
        
        //SearchVC 내리기: present로 할 경우
        //delegate로 값 전달
        delegate?.receiveImage(image: UIImage(systemName: imageList[indexPath.item])!)
        
        dismiss(animated: true)
        
    }
    
    
}

