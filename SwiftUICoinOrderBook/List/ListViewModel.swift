//
//  ListViewModel.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/21/23.
//

import Foundation

//관찰할 수 있도록, 변화 시 View에 신호 전달
class ListViewModel: ObservableObject {
    
    //State 대용
    @Published var market = [Market(market: "a", korean: "b", english: "c"),
                             Market(market: "d", korean: "e", english: "f"),
                             Market(market: "a", korean: "b", english: "c"),
                             Market(market: "a", korean: "b", english: "c")
                            ]
    //sample data: Hashable하지 않으므로 동일한 것 하나만 나타남
    
    
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
                    self.market = decodedData
                }
            } catch {
                print(error)
            }
            
            
            
        }.resume()
        
    }
    
}
