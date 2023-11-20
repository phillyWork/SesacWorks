//
//  ContentView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var banner = "23,456,789원"
    
    //크게 시작, 틀이 잡히면 내부적 update하기
    var body: some View {
        NavigationStack {       //구조 잡히고 나서 NavigationStack 설정
            ScrollView {        //Scroll 되도록
                VStack {
                    bannerView()
                    LazyVStack {                    //필요한 시점에 load하기 (한번에 load하지 않기)
                        ForEach(1..<50) { data in    //Cell 반복: ForEach 구성
                            listView(data: data)
                        }
                    }
                }
            }
            .navigationTitle("My Wallet")       //rootView: ScrollView
            .refreshable {                      //pull to refresh 기능 구현 (iOS 15)
                                                //13, 14: UIKit 코드 wrapping해서 활용
                banner = "35,675,432,089,222원"
            }
        }
    }
    
    func bannerView() -> some View {
        ZStack {        //Rectangle 위에 Text 올리기
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray)
                .frame(maxWidth: .infinity) //padding된 길이 기준 infinity
                .frame(height: 200)
            VStack(alignment: .leading) {   //contents 기준 stack 크기에서 왼쪽 정렬
                Spacer()                //위쪽 영역 채워서 내리기
                Text("나의 소비 내역")
                Text(banner)            //State 변수 활용 --> update되면 body가 다시 그려질 것
            }
            .padding()  //상하좌우 영역 띄워서 너무 딱붙지 않게 만들기
            .frame(maxWidth: .infinity, alignment: .leading)     //padding된 길이만큼, 맨 왼쪽으로 구성
        }
        .padding()      //내부 View 모두 padding 적용
    }
    
    
    //function으로 처리한 이유: 값 전달 처리 (property로는 처리 까다로운 경우 존재)
    func listView(data: Int) -> some View {
        HStack {
            VStack(alignment: .leading) {   //왼쪽 정렬
                Text("비트코인 \(data)")
                Text("Bitcoin")
            }
            Spacer()        //가운데 공간 띄우기
            Text("KRW-BTC")
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)      //개별적인 padding값 적용 (default 값은 iOS 버전마다 달라짐)
    }

}

#Preview {
    ContentView()
}
