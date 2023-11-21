//
//  ListView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/21/23.
//

import SwiftUI

//List에 활용될 별도 View로 분리

struct ListView: View {
    
    //observableObject가 전달한 신호 받을 주체
//    @ObservedObject var listVM = ListViewModel()
    
    //ContentView가 update --> ObservedObject는 data 사라짐 (초기화됨)
    //StateObject: data 유지
    
    //차이점?
    //상위 view 내 하위 view
    //상위 view가 update되어서 body 다시 그림
    //ObservedObject: instance 새로 생성, 교체 (네트워크 통신 이전 상태 불러옴)
    //StateObject: init 다시 되어도 instance 유지
    @StateObject var listVM = ListViewModel()

    

    
    var body: some View {
        
        //onAppear 대신 여기서 서버 통신 시작
        
        //scrollView는 ContentView에서 담김
        
        LazyVStack {
            ForEach(listVM.market, id: \.self) { item in
                
                HStack {
                    VStack(alignment: .leading) {
                        //정적 dummy 확인 후, 통신 결과 활용하기
    //                    Text("비트코인")
                        Text(item.korean)
                        .fontWeight(.bold)
    //                    Text("Bitcoin")
                        Text(item.english)
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    Spacer()
    //                Text("BTC-KRW")
                    Text(item.market)
                }
                .padding()
            }
        }
        .onAppear {
            listVM.fetchAllMarket()
        }
        
    }
}

#Preview {
    ListView()
}
