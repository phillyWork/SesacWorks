//
//  PosterViewController.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/16.
//

import UIKit
import Alamofire
//import SwiftyJSON
import Kingfisher

class PosterViewController: UIViewController {

    @IBOutlet weak var posterCollectionView: UICollectionView!
    
    var totalList = [MovieRecommendation]()
     
//    var list = MovieRecommendation(page: 0, totalPages: 0, results: [], totalResults: 0)
//
//    var secondList = MovieRecommendation(page: 0, totalPages: 0, results: [], totalResults: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //id: 419704, 25538, 965150, 376867, 671
        //dataManager에서 data 가져오면 데이터 가져올 때마다 reload하기
        callRequestRecommendation(id: 671) { recommendation in
//            self.list = recommendation
            
            self.totalList.append(recommendation)
            
            self.posterCollectionView.reloadData()
        }
        
        callRequestRecommendation(id: 419704) { recommendation in
//            self.secondList = recommendation

            self.totalList.append(recommendation)
            
            self.posterCollectionView.reloadData()
        }
        
        callRequestRecommendation(id: 965150) { recommendation in
            self.totalList.append(recommendation)
            
            self.posterCollectionView.reloadData()
        }
        
        callRequestRecommendation(id: 376867) { recommendation in
            self.totalList.append(recommendation)
            
            self.posterCollectionView.reloadData()
        }
        
        
//        callLottoAPI()
//        LottoManager().callLottoAPI()
        
//        //매번 instance 생성보다 type property로 singleton 활용
//        let networkManager = LottoManager.shared
//        //completionHandler로 받아온 data를 활용하기
//        networkManager.callLottoAPI { bonus, numThree in
//            print("클로저로 꺼내온 값: \(bonus), \(numThree)")
//        }
        
        
        //protocol로 관리: 매번 viewDidLoad에 작성할 필요 없음
        configureCollectionView()
        configureCollectionViewLayout()
        
    }
    
//    func configCollectionView() {
//        posterCollectionView.delegate = self
//        posterCollectionView.dataSource = self
//
//        //cell 등록
//        posterCollectionView.register(UINib(nibName: "PosterCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PosterCollectionViewCell")
//
//        //header 등록
//        //SupplementaryViewOfKind: header or footer 사용할 것인지
//        posterCollectionView.register(UINib(nibName: "HeaderPosterCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderPosterCollectionReusableView")
//
//        configCollectionViewLayout()
//    }
    
//    func configCollectionViewLayout() {
//
//        let layout = UICollectionViewFlowLayout()
//
//        //수직 scroll 내 수평 scoll: tableview 내에 각 cell에서 collectionview 넣기
//        //compositional layout으로 더 간편하게 설정 가능
//
//        layout.scrollDirection = .vertical
//
//        layout.itemSize = CGSize(width: 100, height: 100)
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
//
//        //collectionView의 header size 설정 (고정적으로 설정)
//        layout.headerReferenceSize = CGSize(width: 300, height: 50)
//
//        posterCollectionView.collectionViewLayout = layout
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //view hiearchy: 화면 뜨고 나서 alert 떠야 함
        //completionHandler로 확인 버튼 UIAction 클로저 외부에서 활용하기
        showAlert(title: "테스트 alert", message: "잘 동작하네요", button: "배경색 변경 예정") {
            //호출 순서 3.
            print("completionHandler로 UIAction 외부에서 기능 활용 중...")
            self.posterCollectionView.backgroundColor = .lightGray
            
        }
        //호출 순서 1.
        print("showAlert method finished")
    }
    

    func callRequestRecommendation(id: Int, completionHandler: @escaping (MovieRecommendation) -> ()) {
    
        let url = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=\(Key.tmdbAPI)&language=ko-KR"
        
        //JSON 확인용
//        AF.request(url, method: .get).validate(statusCode: 200...500).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print(json)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        //Codable struct 활용
        AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: MovieRecommendation.self) { response in
            switch response.result {
            case .success(let value):
//                self.list = value
//                self.posterCollectionView.reloadData()
                completionHandler(value)
            case .failure(let error):
                print(error)
            }
        }
        
        
        
    }
    
}


extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 4
        return totalList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        print("count for section \(section): \(totalList[section].results.count)")
        return totalList[section].results.count
        
//        print("count: \(list.results.count)")
//        if section == 0 {
//            return list.results.count
//        } else if section == 1 {
//            return secondList.results.count
//        } else {
//            return 9
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = posterCollectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else { return UICollectionViewCell() }
        
        cell.posterImageView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        let imageUrl = "https://image.tmdb.org/t/p/w342\(totalList[indexPath.section].results[indexPath.item].posterPath ?? "")"
        cell.posterImageView.kf.setImage(with: URL(string: imageUrl))

//        if indexPath.section == 0 {
//            let imageUrl = "https://image.tmdb.org/t/p/w342\(list.results[indexPath.item].posterPath ?? "")"
//            cell.posterImageView.kf.setImage(with: URL(string: imageUrl))
//        } else if indexPath.section == 1 {
//            let imageUrl = "https://image.tmdb.org/t/p/w342\(secondList.results[indexPath.item].posterPath ?? "")"
//            cell.posterImageView.kf.setImage(with: URL(string: imageUrl))
//        }
        
        return cell
    }
    
    
    //어떻게 header 사용할 지 결정
    //kind: header인지 footer인지 조건에 따라 디자인 달라질 수 있음
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            guard let view = posterCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier, for: indexPath) as? HeaderPosterCollectionReusableView else { return UICollectionReusableView() }
            
            view.titleLabel.text = "테스트 섹션"
            
            return view
            
        } else {
            return UICollectionReusableView()
        }
        
    }
    
}

//MARK: - Extension for CollectionViewAttributeProtocol

extension PosterViewController: CollectionViewAttributeProtocol {
    
    func configureCollectionView() {
        posterCollectionView.delegate = self
        posterCollectionView.dataSource = self
        
        //cell 등록
        posterCollectionView.register(UINib(nibName: PosterCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        
        //header 등록
        //SupplementaryViewOfKind: header or footer 사용할 것인지
        posterCollectionView.register(UINib(nibName: HeaderPosterCollectionReusableView.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderPosterCollectionReusableView.identifier)
        
    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        //수직 scroll 내 수평 scoll: tableview 내에 각 cell에서 collectionview 넣기
        //compositional layout으로 더 간편하게 설정 가능
        
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        //collectionView의 header size 설정 (고정적으로 설정)
        layout.headerReferenceSize = CGSize(width: 300, height: 50)
        
        posterCollectionView.collectionViewLayout = layout
    }
    
    
}



//MARK: - Test for self with protocol

////protocol도 비슷한 성질 가짐
//protocol Test {
//    func test()
//}
//
////protocol 채택: method 구현해야 함
//class A: Test {
//    func test() {
//    }
//}
//
//class B: Test {
//    func test() {
//    }
//
//}
//
//class C: A {
//}
//
////instance 생성, value에 할당
////변수 타입: A class
//let value = A()
//
////A 상속받는 C instance
////superclas로 인지
//let value2: A = C()
//
//
////protocol type으로 선언
////protocol도 type처럼 기능할 수 있음
////Test protocol 채택한 모든 instance 할당받을 수 있음
//let example: Test = A()
//
//let example2: Test = B()









