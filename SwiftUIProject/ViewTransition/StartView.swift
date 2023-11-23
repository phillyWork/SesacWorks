//
//  StartView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/15.
//

import SwiftUI

struct StartView: View {
    
    var body: some View {
        
        TabView {
            
            //모든 View가 Scene으로 역할을 할 수 있음
            //단순 Text() --> 직접 생성한 View까지도
            
            Text("1")
                .tabItem {
                    Text("Home")
                    Image(systemName: "house.fill")
                }
            HomeView()
                .tabItem {
                    Text("Like")
                    Image(systemName: "star")
                }
            RenderView()
                .tabItem {
                    Text("Post")
                    Image(systemName: "pencil")
                }

            Text("4")
                .tabItem {
                    Text("Search")
                    Image(systemName: "magnifyingglass")
                }

        }
        
    }
    
}

#Preview {
    StartView()
}
