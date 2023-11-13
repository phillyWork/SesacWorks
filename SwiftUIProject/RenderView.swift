//
//  RenderView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/13.
//

import SwiftUI

//View가 그려지는 과정 확인
struct RenderView: View {

    @State var age = 10

    //연산 프로퍼티처럼 따로 빼기
    var bran: some View {
        Text("Bran: \(Int.random(in: 1...100))")
    }
        
    var body: some View {
        VStack {
            Text("Hue: \(age), \(Int.random(in: 1...100))")
            Text("Jack: \(Int.random(in: 1...100))")
            bran
            kokoView()
            Button("클릭") {
                //data 변화 주기
                //age가 변화: age만 그대로?
                
                //struct 내부의 값 변화: mutating 필요
                //@State 활용
                age = Int.random(in: 1...100)
                
                //실제 변화: subview로 분리한 koko 제외 버튼 눌릴때마다 다 변화함
                //body가 새롭게 계속 그려짐
                
            }
        }
    }
}

#Preview {
    RenderView()
}

//subview로 분리
struct kokoView: View {
    var body: some View {
        Text("Koko: \(Int.random(in: 1...100))")
    }
}
