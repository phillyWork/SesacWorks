//
//  ContentViewModel.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/21/23.
//

import Foundation

//ObservableObject: 달라지는 것 관리, 인지 (관찰자)
class ContentViewModel: ObservableObject {
    
    //network 호출을 View에서 처리하지 않도록
    
    //State에 대한 정보 handling 관리
    
    //View가 아니므로 더 이상 속한 View 정보 알 수 없음
    
    //State -> Published로 변경
    //변경때마다 view update

//    @Published var banner = "23,456,789원"
    
    @Published var banner = Banner()
    @Published var money: [Market] = []
        
    //banner update를 viewModel에서 처리하기
    func fetchBanner() {
        //새로운 instance로 교체하기
        banner = Banner()
    }
    
    //Network 함수 가져옴
    func fetchAllMarket() {
        
        let url = URL(string: "https://api.upbit.com/v1/market/all")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            //에러, 상태코드는 생략
            
            guard let data = data else {
                print("데이터 응답 없음")
                return
            }
            
            do {
                //배열로 들어오는 Market --> 처음 받을때는 배열로 담아야 함
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                print("data 확인 목적: ", decodedData)
                
                //URLSession: concurrent하게 처리 기본
                //main thread에서 처리하도록
                DispatchQueue.main.async {
//                    completionHandler(decodedData)
                    
                    //ViewModel로 이동: money property에 내용 바로 전달하기
                    //completoinHandler 필요 없어짐
                    self.money = decodedData
                }
            } catch {
                print(error)
            }
            
            
            
        }.resume()
        
    }
    
}
