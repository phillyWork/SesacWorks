//
//  GridView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/17.
//

import SwiftUI

//lazyStack이 해결할 수 없는 내용들 해결
//collectionView 역할
struct GridView: View {
    
    //Binding으로 받기
    @Binding var movieData: [Movie]
    
    //element 100개의 String 배열
    @State var dummy = Array(1...100).map { "오늘의 영화 순위 \($0)" }
    
    //View 복잡 ~ column 별도 property로 분리
    //fixed: 고정값
    private let fixedLayout = [
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120)),
        GridItem(.fixed(120))
    ]
    
    //유연하게 대응
    //flexible: 최소 ~ 최대 범위 설정 (fixed로 먼저 채우고 남은 영역 계산해서 채우기)
    private let flexibleLayout = [
        GridItem(.flexible(minimum: 100, maximum: 250)),
        GridItem(.fixed(100)),
        GridItem(.fixed(100)),
    ]

    //더 대응: 큰 사이즈로 flexible 설정 --> 1/n로 설정
    private let flexibleLayout2 = [
        GridItem(.flexible(minimum: 100, maximum: 300)),
        GridItem(.flexible(minimum: 100, maximum: 300)),
        GridItem(.flexible(minimum: 100, maximum: 300)),
    ]
    
    //spacing: 여백 보장
    private let layout = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
    ]
    
    
    var body: some View {
       
        //column: size --> cell 크기 설정
        //content: 어떤 view 담을 것인지
        
        //scroll하려면 ScrollView로 wrapping 필요
        ScrollView {
            LazyVGrid(columns: layout, content: {
                ForEach(dummy, id: \.self) { item in
                    ZStack {
                        Color.random()
                        Text(item)
                    }
                }
            })
            .padding()
        }
        //화면 등장 시, 작업할 내용들
        .onAppear {
            //dummy 수정, 구조체에서 값 변경 --> @State로 update 필요
            dummy.insert("새로운 데이터", at: 0)
        }
        //화면 등장 시, 비동기로 처리 (iOS 15부터)
        .task {
            //e.g.) 네트워크 통신 작업들
            
        }
    }
    
}

#Preview {
    //constant로 binding 처리 필요
    GridView(movieData: .constant(
        [
            Movie(title: "SF"),
            Movie(title: "로맨스"),
            Movie(title: "공포"),
            Movie(title: "애니메이션"),
            Movie(title: "스릴러")
        ]
    ))
}
