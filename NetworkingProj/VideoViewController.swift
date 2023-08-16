//
//  VideoViewController.swift
//  NetworkingProj
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

//custom data
struct Video {
    let author: String
    let date: String
    let time: Int
    let thumbnail: String
    let title: String
    let link: String
    
    //연산 프로퍼티로 한번에 나타나기 가능
    var contents: String {
        return "\(author) | \(time)회\n\(date)"
    }
}

//e.g.) 만약 모든 video가 youtube 출처: https://www.youtube.com/watch? ~ 공통 url
//response에서 queryString에 해당하는 것만 전달할 수 있음
//달라지는 contents만 제공 (data 경량화 목적)


class VideoViewController: UIViewController {

//    var videoList: [String] = []
//    var videoList: [Video] = []
    var videoList: [Document] = []

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var videoTableView: UITableView!
    
    //몇 번째 page 볼 지 결정
    var pageNum = 1
    
    //현재 page가 마지막 page인지 추적
    var isEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoTableView.delegate = self
        videoTableView.dataSource = self
        
        //재사용시 자기 멋대로 변화됨: cell 높이 명시적 설정 필요
        videoTableView.rowHeight = 140
        
        //prefetch protocol 연결
        videoTableView.prefetchDataSource = self
        
        //searchBar 연결
        searchBar.delegate = self
        
//        callRequest(query: "아이유")
    }
    

    func callRequest(query: String, page: Int) {

//        //invalidURL(url: "https://dapi.kakao.com/v2/search/vclip?query=아이유")
//        //한글: url이 인식할 수 있도록 encoding 필요
//
//        //encoding 종류 다양함 (% 문자 처리 관련)
//        guard let searchText = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//            print("Cannot encode text!")
//            return
//        }
//
//        //한 page 내 몇 개 보여줄지 설정
//        //몇번째 page를 볼지 설정
//        let url = "https://dapi.kakao.com/v2/search/vclip?query=\(searchText)&size=10&page=\(page)"
//
//        //header에 authorization key를 넣는 경우
//        //dictionary 형태, key-value로 넣기
//        //HTTPHeaders type 맞게 설정
//        let header: HTTPHeaders = ["Authorization": APIKey.kakaoAK]
        
        
        //singleton instance 활용하기
        //type에 따른 호출 요청 with queryString
        //AlamoFire 작업: manager에서 처리
        //response로 넘어오는 json을 closure가 받아서 처리
        //어떻게 처리? 여기서 구현
//        KakaoAPIManager.shared.callRequest(query: query, type: .video) { json in
//            //결과로 넘어온 json을 가지고 어떻게 처리할지 실제 구현 내용들
//            print("========\(json)")
//        }

        
        KakaoAPIManager.shared.callRequest(query: query, type: .video, page: page) { result in
            for document in result.documents {
                self.videoList.append(document)
            }
            self.videoTableView.reloadData()
        }
        
        

        //에러 치러: 상태 코드 파악 --> error 영역도 성공 처리하기
//        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
////                print(json)
//
//                //상태 코드에 따른 json 구조 달라짐
//                //조건으로 분기 처리 필요 (예외 처리 필요)
//
//                //response 매개변수에서 서버의 응답 내 데이터 중 상태 코드 확인
////                print(response.response?.statusCode)
//
//                //optional chaining nil 대응하기
//                let statusCode = response.response?.statusCode ?? 500
//
//                //실제 서비스: 각 code에 맞게 대응함
//                if statusCode == 200 {
//
//                    //마지막 page인지 추적 필요
//                    self.isEnd = json["meta"]["is_end"].boolValue
//
//                    let dataArray = json["documents"].arrayValue
//                    for data in dataArray {
//
//                        let title = data["title"].stringValue
//                        let author = data["author"].stringValue
//                        let date = data["datetime"].stringValue
//                        let time = data["play_time"].intValue
//                        let thumbnail = data["thumbnail"].stringValue
//                        let link = data["url"].stringValue
//
//
//    //                    self.videoList.append(title)
//                        let video = Video(author: author, date: date, time: time, thumbnail: thumbnail, title: title, link: link)
//                        self.videoList.append(video)
//                    }
//
////                    print(self.videoList)
//                    //data 가지고 오면 갱신
//                    self.videoTableView.reloadData()
//
//                } else {
//                    print("문제 발생. 잠시 후 다시 시도해주세요.")
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        }


    }
    
    
   

}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        videoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //protocol 채택 --> Cell에 identifier 따로 없어도 class의 type property로 활용 가능
        guard let cell = videoTableView.dequeueReusableCell(withIdentifier: VideoCell.identifier) as? VideoCell else {
            return UITableViewCell()
        }
    
//        cell.titleLabel.text = videoList[indexPath.row].title
//        cell.contentLabel.text = videoList[indexPath.row].contents
        
        cell.titleLabel.text = videoList[indexPath.row].title
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: videoList[indexPath.row].datetime) {
            cell.contentLabel.text = "\(videoList[indexPath.row].author) | \(videoList[indexPath.row].playTime)회 \(date)"
        }
        
        //link 동작 여부 문제 없는지 확인 필요 (link 변경, encoding 여부, 혹은 달라진 queryString 등등...)
        if let url = URL(string: videoList[indexPath.row].thumbnail) {
            cell.thumbnailImageView.kf.setImage(with: url)
        }
    
        return cell
    }
    
}

//iOS 10 이상 사용 가능 프로토콜
//cellForRowAt 메서드 호출 전 미리 호출됨
extension VideoViewController: UITableViewDataSourcePrefetching {
   
    //cell 화면 보이기 직전에 필요한 리소스 미리 다운받기: cellForRowAt 전에 먼저 수행
    //data 개수와 indexPath.row 위치를 비교, 마지막 스크롤 시점 확인: 네트워크 요청 시도
    //page count, isEnd property 필요
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        //page 언제 올려줄 지: 타이밍 설계
        //e.g.) 2/3 넘어가거나, 1,2개 남았을 때 --> 다보고 새로 가져오면 사용자 살짝 기다려야 함
        
        for indexPath in indexPaths {
            
            //고려 사항들
            //1. kakao API: page 15까지만 허용 --> 16부터 에러 코드 나타냄 (API 제공 업체마다 달라짐)
            //2. 검색 결과가 page의 15까지 넘어가지 않을 수 있음 (현재 page가 마지막 page인지 확인 필요)
            if videoList.count - 1 == indexPath.row && pageNum < 15 && !isEnd {       //data가 현재 page에서 마지막일 때, page가 15보다 크지 않으면서, 마지막 page가 아닐 때 수행
                print("It's getting new data!")
                //다음 page data 요구하기
                pageNum += 1
                //기존 입력되어 있는 searchBar 입력값의 다음 page data 가져오기
                callRequest(query: searchBar.text!, page: pageNum)
            }
        }
    
    }
    
    
    //직접 취소 기능 구현 필요
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
        print("====취소: \(indexPaths)")
        
    }
    
    
}


extension VideoViewController: UISearchBarDelegate {
    
    //실시간 검색: 검색값 변화마다 계속 서버 통신함
    //접속 트래픽이 많다면 서버에서 block 당할 수도 있음
    //엔터키 입력 시 서버에서 검색하기
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //각 search 결과에 대한 배열 초기화 필요
        videoList.removeAll()
        
        //새로운 검색: page의 내용도 1로 초기화되어야 함
        pageNum = 1
        
        view.endEditing(true)
        
        guard let query = searchBar.text else { return }
        
       //searchBar에서 검색: 새로운 결과물 보기 --> 첫 페이지 보여주기
        callRequest(query: query, page: pageNum)
    }
    
    
    
    
   
    
    
}

