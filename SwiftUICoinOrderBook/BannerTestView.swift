//
//  BannerTestView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/21/23.
//

import SwiftUI

struct BannerTestView: View {
    
    //ContentView에서 넘어온 @State data update하기
    @Binding var testNumber: Int
    
    var body: some View {
        VStack {
            Text("테스트: \(testNumber)")
            Button("숫자 업데이트") {
                //@Binding으로 받아온 @State의 값 update 시, 적용됨?
                
                testNumber = Int.random(in: 1...100)
            }
        }
    }
}

#Preview {
    BannerTestView(testNumber: .constant(5))
}
