//
//  MovieViewSecond.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/14.
//

import SwiftUI

struct MovieViewSecond: View {
    
    @State private var isPresented = false
    
    var body: some View {
        //addSubView처럼 쌓는 과정
        ZStack {
            
            Color.green
            
            Image(.dinosaur)
                .resizable()            //화면 크기에 맞게 조정
                .scaledToFit()          //contentMode 설정
                .ignoresSafeArea()
            
            
            Image("dinosaur")
                .resizable()
                .frame(width: 100, height: 100) //직접 크기 설정
                .border(Color.white, width: 5)
            
            Text("ㅋㅋㅋㅋㅋㅋㅋ")
                .font(.title)
                .foregroundStyle(Color.orange)
            
            VStack {
                //화면 전환용
                Button("SHOW") {
                    //버튼 누르면 화면 띄우기: State로 관리
                    isPresented = true
                }
                .padding()
                .background(.white)
                
                Spacer()
                
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
            }
            .background(.orange)
        }
        //전체 View 기준으로 띄워져야 함: Zstack 기준 띄우기
        
        //present 방식도 modifier로 제공
        
        //sheetPresentation으로 띄우기
        .sheet(isPresented: $isPresented, content: {
            TamagochiView()
        })
        
        //fullScreen으로 띄우기
//        .fullScreenCover(isPresented: $isPresented, content: {
//            TamagochiView()
//        })
        
        
    }
}

#Preview {
    MovieViewSecond()
}
