//
//  ContentView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/13.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, worsdfsdld!")
//        }
//        .padding()
        
        //struct: class와 달리 property 접근 없이도 바로 적용 가능
        Text("안녕하세요")
//            .foregroundColor(.blue)     //deprecated
            .foregroundStyle(Color.blue)
            //padding 순서 따라서 적용 결과 달라질 수 있음 (data stream처럼)
//            .padding()
//            .bold()
            .font(.largeTitle)
            .background(Color.yellow)
            .padding()
            .background(Color.red)
            .border(.purple, width: 5)
//            .clipShape(Circle())      //원으로 잘라내기

        
        Button("클릭하기") {
            //Body가 가진 type 체크하기
            let value = type(of: self.body)
            print("Type of body: ", value)      //Button<Text>
        }
        .foregroundStyle(Color.green)
        .background(.pink)
        
    }
}

#Preview {
    ContentView()
}
