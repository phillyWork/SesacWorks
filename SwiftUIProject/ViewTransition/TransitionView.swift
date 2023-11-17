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
//    @State private var isPush = false
    
    
    //init 확인
    init(isFull: Bool = false, isSheet: Bool = false) {
        self.isFull = isFull
        self.isSheet = isSheet
        print("TransitionView init")
    }
    
    
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
              
                //instance로 RenderView 갖기 위해 미리 호출 --> RenderView init 호출
                //if) RenderView에서 네트워크 통신 --> NavigationLink로 인해 이미 통신 시작
                
                //resource 낭비 막아보기: RenderView가 중요, 네트워크 통신
                //RenderView를 바로 호출하지 않고 View로 감싸기 (NavigationLazyView)
                //NavigationLazyView의 body 내 RenderView 위치
                
                NavigationLink("Push") {
                    //generic 활용한 LazyView 활용
                    
                    //RenderView를 최종적으로 return하는 View 가짐
                    
                    //autoclosure 활용, 중괄호 없애기
                    NavigationLazyView(RenderView())
                    
//                    NavigationLazyView {
//                        RenderView()
//                    }
                    
//                    NavigationLazyView()
//                    RenderView()
                }
                
                //우려점: 다른 View를 띄우고 싶을 경우
                //NavigationLazyView를 하나 더 만들기
                
                //View 수가 많아질 수록 새로운 NavigationLazyView struct를 만들어야 함
                
                //해결: Generic을 활용 (결국 Body 내 View만 들어가면 됨)
                NavigationLink("Push") {
//                    NavigationLazyView2()
                    
                    //autoclosure 활용
                    NavigationLazyView(PosterView())
                    
//                    NavigationLazyView {
//                        PosterView()
//                    }
                }
                
            }
            //binding으로 하위 view에서 가져다 활용
            .sheet(isPresented: $isSheet, content: {
                RenderView()
            })
            .fullScreenCover(isPresented: $isFull, content: {
                //dismiss 요소 구성
                RenderView()
                
            })
            
        }
        
    }
    
}

#Preview {
    TransitionView()
}
