//
//  CategoryView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/15.
//

import SwiftUI

//struct로 데이터 받아서 활용하는 경우
//각 data가 Hashable해야 ForEach에서 KeyPath 활용 가능
//겹치는 data가 존재하면 UUID 설정해서 Hashable 채택 가능하도록 설정 가능
struct Category: Hashable, Identifiable {
    //초기화 시, 각 data 고유 UUID값 활용
    //관리 목적: 강제적으로 활용 ~ Identifier protocol 채택
    //id 변수 필수 구현, 변수 이름 변경 시 에러 호출
    let id = UUID()
    let name: String
    let count: Int
}

struct CategoryView: View {
    
//    let category = ["스릴러", "액션", "SF", "코미디", "가족", "로맨스", "드라마", "공포", "스포츠", "다큐"]
    
    let category = [
        Category(name: "스릴러", count: 10),
        Category(name: "액션", count: 50),
        Category(name: "SF", count: 7),
        Category(name: "코미디", count: 11),
        Category(name: "가족", count: 5),
        Category(name: "로맨스", count: 8),
        Category(name: "드라마", count: 12),
        Category(name: "공포", count: 18),
        Category(name: "스포츠", count: 23),
        Category(name: "다큐", count: 98),
        Category(name: "다큐", count: 98),
    ]
    
    var body: some View {
        
        //View가 담을 수 있는 개수 제한 풀림 (Xcode14: 10개까지)
        VStack {
            
            //반복문으로 구성
            //ForEach: 양쪽 다 포함은 불가 (0...50: error)
//            ForEach(0..<50) { item in
            
            //데이터 직접 활용
//            ForEach(0..<category.count) { item in
            
            //Integer literal로 활용하기: id 활용
            //ForEach: 고유값 판단 기준 ~ id 매개변수 활용
            //KeyPath 활용: \. ==> Keypath 기반 판단으로 item으로 들어옴
            //id: Hashable해야 함
                        
            //struct로 data 구성: 각 data가 Hashable해야 함
            
            //item으로 넘어간 struct 그 자체 (self): 내부 property로 text나 count 사용할지 설정 필요
//            ForEach(category, id: \.self) { item in

            //self외에 다른 것도 설정 가능
            //name으로 Hashable 기준 --> 동일 name 존재: 한번 설정된 값으로 반복됨 (Build 오류는 안 나옴)
//            ForEach(category, id: \.name) { item in
            
            //겹치는 값 존재하는 경우는 id로 설정하지 않거나, 따로 id로 활용할 property를 struct에 구성하기 ~ UUID
            ForEach(category, id: \.id) { item in
                Text("\(item.name): \(item.count)개, 안녕하세요")
                    .font(.largeTitle)
            }
            
        }
        
    }
    
}

#Preview {
    CategoryView()
}
