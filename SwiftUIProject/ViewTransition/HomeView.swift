//
//  HomeView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/15.
//

import SwiftUI

//Netflix 애니메이션
struct HomeView: View {
    
    var body: some View {
        
        //Vstack이 scroll되도록
        ScrollView {
            //전체 수직 scroll되려는 content
            VStack(spacing: 50) {
                //가로 scroll되는 section 하나
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<10) { item in
                            AsyncImageViewSecond()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<10) { item in
                            AsyncImageViewSecond()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<10) { item in
                            AsyncImageViewSecond()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<10) { item in
                            AsyncImageViewSecond()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<10) { item in
                            AsyncImageViewSecond()
                                .frame(width: 300, height: 200)
                        }
                    }
                }
                
            }
        }
    }
    
    
}

#Preview {
    HomeView()
}
