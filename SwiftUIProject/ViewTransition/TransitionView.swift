//
//  TransitionView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/15.
//

import SwiftUI

//Button tap 및 swipe 등의 액션으로 화면 dismiss/pop 구현
//화면 전환 시의 데이터 전달
//화면 전환 시의 분기 처리 (다양한 화면으로 전환)

struct TransitionView: View {
    
    //Button action 여부 관리용 --> View가 의존, Body render 기준
    @State private var isFull = false
    @State private var isSheet = false
    @State private var isPush = false
    
    var body: some View {
        
        NavigationView {
            
            HStack(spacing: 20) {
                
                Button("Full") {
                    isFull.toggle()
                }
                
                Button(action: {
                    isSheet.toggle()
                }, label: {
                    Text("Sheet")
                })
                                
//                NavigationLink("Push") {
//                    isPush.toggle()
//                }
                
            }
            //binding으로 하위 view에서 가져다 활용
            .sheet(isPresented: $isSheet, content: {
                RenderView()
            })
            .fullScreenCover(isPresented: $isFull, content: {
                RenderView()
            })
            
        }
        
    }
    
}

#Preview {
    TransitionView()
}
