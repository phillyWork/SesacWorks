//
//  ChartView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/17.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    //SearchView에서 넘어오는 데이터 담기
    let movieData: [Movie]
    
    //light, dark mode 대응
    @Environment(\.colorScheme) var color
    
    //View가 복잡: property로 분리
    
    //많은 객체를 활용하면 조건문으로 분기 처리
    
    //실행되지 않는 문제
    //해결: ViewBuilder property wrapper 활용
    
    //Xcode 14 이전: body 제외 모든 property 및 method: View return 시 필수
    //body는 ViewBuilder 내장

    //closure 구문 --> Stack 반환값: Content(View)
    
    //Xcode 15에서 완화: 조건문 제외에서는 생략 가능
    
    //Custom한 View로 wrapping해서 활용도 가능
    @ViewBuilder
    var chartTitle: some View {
//        Text(color == .dark ? "다크 차트" : "라이트 차트")
    
        if color == .dark {
            HStack {
                Image(systemName: "star.fill")
                Text("다크 차트")
            }
        } else {
            Text("라이트 차트")
        }
        
        //데이터 기반으로 Text 구분 가능
        
        
        
    }
    
    var body: some View {
        //UIKit: 라이브러리 활용
        //iOS 16부터 SwiftUI 차트 기능 활용 가능 (Charts framework)
        
        VStack {
            //property로 분리
            chartTitle
            
            //id: 고유값 활용 (UUID id 혹은 구조체 자체가 hashable하면 self)
            //content: 어떤 차트 활용할 것인지
            Chart(movieData, id: \.self) { item in
                //각 item을 어떻게 나타낼 지
                
                //Bar ~ 범위 자동 잡아줌, 세부 설정도 가능
                //PlottableValue: data와 축 기준

                //X축 Y축 활용 ~ 종류 다양 (검색해서 활용하기)
//                BarMark(
//                RectangleMark(
//                LineMark(
                AreaMark(
                    x: .value("장르", item.title),
                    y: .value("관람 횟수", item.count)
                )
                //Bar 색상 변화
                .foregroundStyle(Color.random())
                
            }
            .frame(height: 200)
        }
        .padding()

    }
    
}

#Preview {
    //Preview 오류 --> instance 생성에 dummy 데이터 필요
    ChartView(movieData: [
        Movie(title: "SF"),
        Movie(title: "로맨스"),
        Movie(title: "공포"),
        Movie(title: "애니메이션"),
        Movie(title: "스릴러")
    ])
}
