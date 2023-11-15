//
//  MovieView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/14.
//

import SwiftUI

//이미지 다루기

struct MovieView: View {
    
    var body: some View {
        //addSubView처럼 쌓는 과정
        ZStack {
            //Color: View 종류
            Color.green
                .ignoresSafeArea()      //safeArea까지 꽉 차도록 설정
            Image(.dinosaur)
                .resizable()            //화면 크기에 맞게 조정
                .scaledToFit()          //contentMode 설정
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack {
                    Image("dinosaur")
                        .resizable()
                        .frame(width: 100, height: 100) //직접 크기 설정
                        .border(Color.white, width: 5)
                    
                    Text("ㅋㅋㅋㅋㅋㅋㅋ")
                        .font(.title)
                        .foregroundStyle(Color.orange)
                }
                Spacer()
                
                //여러 도형 활용
//                HStack {
//                    Circle()
//                    Rectangle()
//                    RoundedRectangle(cornerRadius: 20)
//                        .fill(.white)
//                    Capsule()
//                }
                
//                VStack {
//                    Spacer()
                    HStack(spacing: 10) {
                        
                        Image("dinosaur")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .border(Color.white, width: 5)
                        
                        Image("dinosaur")
                            .resizable()
                            .frame(width: 100, height: 100) //직접 크기 설정
                            .border(Color.white, width: 5)
                        
                        Image("dinosaur")
                            .resizable()
                            .frame(width: 100, height: 100) //직접 크기 설정
                            .border(Color.white, width: 5)
                        
                    }
//                }
            }
        }
        
    }
    
}

#Preview {
    MovieView()
}
