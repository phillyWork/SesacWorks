//
//  ViewController.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

//구조체로 데이터 확보하기
struct Movie {
    var movieTitle: String
    var releaseDate: String
}

class MovieViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var movieTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
//    var movieList: [String] = []
    //구조체로 데이터 관리
    var movieList: [Movie] = []
    
    //MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        configSearchBar()
        
        //서버 통신 작동 확인 목적
        //목적에 맞게 서버 통신 구현 --> 주로 제거
//        callRequest(date: "20230809")
        
        
        //app 시작: 화면 뜨기 전에 indicator 숨기기
        indicatorView.isHidden = true
    }
    
    func configTableView() {

        movieTableView.dataSource = self
        movieTableView.delegate = self
        
        movieTableView.rowHeight = 60
    }
    
    func configSearchBar() {
        searchBar.delegate = self
    }
    
    
    //MARK: - API
    
    func callRequest(date: String) {

        //indicator 애니메이션 시작
        indicatorView.startAnimating()
        
        //서버 통신 시작 전 indicator 보여주기
        indicatorView.isHidden = false
                
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIKey.boxOfficeKey)&targetDt=\(date)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
//                print("JSON: \(json)")
                
                //원하는 data를 얻기 위해 순서대로 parsing 해야함
                //let name = json["movieNm"].stringValue
                
                //json []: 배열로 데이터 저장 --> index 몇번째 찾을 것인지 판단 필요
                //개별로 찾을 경우
//                let name1 = json["boxOfficeResult"]["dailyBoxOfficeList"][0]["movieNm"].stringValue
//                let name2 = json["boxOfficeResult"]["dailyBoxOfficeList"][1]["movieNm"].stringValue
//                let name3 = json["boxOfficeResult"]["dailyBoxOfficeList"][2]["movieNm"].stringValue
//                self.movieList.append(contentsOf: [name1, name2, name3])
                
                
                //tableViewCell에 보여주기: 반복문으로 전체 data 가져오기
                //배열을 돌기 위함: arrayValue 설정
                let dailyList = json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue

                for item in dailyList {
                    let movieName = item["movieNm"].stringValue
                    let releaseDate = item["openDt"].stringValue

//                    self.movieList.append(movieName)
                                    
                    //담을 data 상수로 설정
                    let movie = Movie(movieTitle: movieName, releaseDate: releaseDate)
                    self.movieList.append(movie)
                }
                
                //통신 완료: 애니메이션 종료 (보이지 않지만 멈추지 않으면 계속 animation 진행)
                self.indicatorView.stopAnimating()
                //서버에서 받아온 데이터 저장 후 view 갱신 직전: indicator 숨기기
                self.indicatorView.isHidden = true
                
                //data 가져옴: tableView 갱신 필수
                self.movieTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    

}

//MARK: - Extension for TableView Delegate, DataSource

extension MovieViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //tableView 기본 코드 작동 확인 목적
//        return 30
        //실제 데이터 개수만큼 보이기
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = movieTableView.dequeueReusableCell(withIdentifier: "MovieCell")!
        
        //실제 데이터 적용하기
        //구조체로 데이터 적용
        cell.textLabel?.text = movieList[indexPath.row].movieTitle
        cell.detailTextLabel?.text = movieList[indexPath.row].releaseDate
        
        return cell
    }
    
}

//MARK: - Extension for SearchBar Delegate

extension MovieViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        movieList.removeAll()
        
        //서버 통신 위한 숫자 입력 고려사항들: 20230810
        //1. 8글자 2. 날짜 범위, 형식 체크 3. 영진원 가장 최근: 어제 날짜까지
        
        callRequest(date: searchBar.text!)
        
    }
    
    
}
