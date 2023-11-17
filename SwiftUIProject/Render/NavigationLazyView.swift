//
//  NavigationLazyView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/16.
//

import SwiftUI

//TransitionView --> NavigationLink: NavigationLazyView 호출
//NavigationLazyView --> body 내 RenderView 위치하기


//Generic으로 body 내 들어갈 타입만 설정
struct NavigationLazyView<T: View>: View {
    
    //custom Observable class와 구조 유사
    
    let build: () -> T
    
    //매개변수 생략 with _
    
    //autoclosure: 중괄호 생략
    
    init(_ build: @autoclosure @escaping () -> T) {
        //외부에서 전달받은 T type 받아서 build에 담기
        //body 내에 data 넣기 위한 escaping closure 구조
        self.build = build
    }
    
    var body: some View {
        
        //T type의 property 넣기
        build()
        
//        RenderView()
    }
    
}

//다른 View 나타내고 싶은 경우
//View 수가 많아질 수록 LazyView도 늘어나야 하는 문제 발생
//해결: generic 활용

//struct NavigationLazyView2: View {
//    
//    var body: some View {
//        CategoryView()
//    }
//    
//}

//#Preview {
//    NavigationLazyView {
//        <#code#>
//    }
//}
