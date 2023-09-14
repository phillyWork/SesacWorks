//
//  LottoManager.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/17.
//

import Foundation
import Alamofire

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

//통신만 담당
class LottoManager {
    
    //network 통신용 singleton 활용
    static let shared = LottoManager()
    private init() {}
    
    //응답 받아서 VC에서 필요한 데이터만 가져다 활용하기
    func callLottoAPI(completionHandler: @escaping (Int, Int) -> ()) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1080"
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                guard let value = response.value else { return }
                print("responseDecodable:", value)
                
                //응답이 오면, PosterVC에 전달해서 활용하도록 함
                completionHandler(value.bnusNo, value.drwtNo3)
            }
    }
    

}
