//
//  ContentView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var banner = "23,456,789원"
    
    //trigger되면 Money 배열에 data 넣어서 body update
    @State private var money: [Money] = []
    
    //크게 시작, 틀이 잡히면 내부적 update하기
    var body: some View {
        NavigationStack {       //구조 잡히고 나서 NavigationStack 설정
            ScrollView {        //Scroll 되도록
                VStack {
                    ScrollView(.horizontal) {            //가로 scroll
                        LazyHStack {        //banner 여럿 구성, 최적화 고려
                                            //frame height 200 기준, contents 양만큼 가로 크기 줄어듬
                            ForEach(1..<5) { data in    //반복 구성
                                bannerView()
                                    .containerRelativeFrame(.horizontal)    //iOS 17+
                                                                            //상위 view의 frame에 맞게끔 사이즈 설정
                            }
                        }
                        .scrollTargetLayout()           //scroll 대상 layout 지정 (iOS 17+)
                    }
                    .scrollTargetBehavior(.viewAligned)     //scroll 타겟으로 설정 (iOS 17+)
                                                            //viewAligned: view 중앙 기준 설정
                                                            //paging: frame 기준 (살짝 밀림)
//                    .safeAreaPadding([.horizontal], 40)     //상,하,좌,우 설정 영역에 padding값 줘서 다음 banner 보이도록 설정 (iOS 17+)
                    
                    //scroll 되는 것 보여주기 ~ page control 달기 --> SwiftUI에서는 아직 지원하지 않음
                    //현재로는 UIKit code를 활용
                    
                    .scrollIndicators(.visible)         //상위 view와 다른 값의 하위 view 동일 속성: 하위 view의 값을 우선 적용
                    LazyVStack {                    //필요한 시점에 load하기 (한번에 load하지 않기)
                        ForEach(money, id: \.id) { data in    //Cell 반복: ForEach 구성
                            listView(data: data)
                        }
                    }
                }
            }
            .navigationTitle("My Wallet")       //rootView: ScrollView
            .scrollIndicators(.hidden)          //scroll indicator 숨기기 (내부 scrollView도 적용)
            .refreshable {                      //pull to refresh 기능 구현 (iOS 15)
                                                //13, 14: UIKit 코드 wrapping해서 활용
                banner = "35,675,432,089,222원"
                money = dummy.shuffled()        //shuffled: 매번 호출될 때마다 순서 섞임
            }
            .onAppear {                         //onAppear: viewWillAppear 유사 역할
                money = dummy.shuffled()
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
            .visualEffect { content, geometryProxy in
                content.offset(x: scrollOffset(geometryProxy))          //Text 담은 VStack에 추가 애니메이션 적용
                                        //비율로 잡기: geomtryProxy 활용 ~ 상위 view의 size 얻어올 수 있음 (iOS 17+)
                                        //어디서 시작해야 (이전 view가 멈출 위치)
            }
            .padding(.vertical)  //영역 띄워서 너무 딱붙지 않게 만들기
            .frame(maxWidth: .infinity, alignment: .leading)     //padding된 길이만큼, 맨 왼쪽으로 구성
        }
        .padding()      //내부 View 모두 padding 적용
    }
    
    //GeometryProxy: container view에 대한 좌표, 크기 접근 가능
    func scrollOffset(_ proxy: GeometryProxy) -> CGFloat {
        //scrollView의 최소치에서 멈추도록 위치 설정
        //scrollView 존재하지 않으면 0을 return
        let result = proxy.bounds(of: .scrollView)?.minX ?? 0
        //안쪽에 위치하도록 음수 설정
        return -result
    }
    
    //function으로 처리한 이유: 값 전달 처리 (property로는 처리 까다로운 경우 존재)
    func listView(data: Money) -> some View {
        HStack {
            VStack(alignment: .leading) {   //왼쪽 정렬
                Text(data.product)
                Text(data.category.rawValue)
            }
            Spacer()        //가운데 공간 띄우기
            Text(data.amountFormat)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 8)      //개별적인 padding값 적용 (default 값은 iOS 버전마다 달라짐)
    }

}

#Preview {
    ContentView()
}
