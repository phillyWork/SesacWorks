//
//  NavStackView.swift
//  SwiftUIAssignments
//
//  Created by Heedon on 2023/11/17.
//

import SwiftUI

struct Movie: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let count = Int.random(in: 1...100)
}


struct NavStackView: View {
    
    @State private var searchQuery = ""
    
    let movieStructArray = [Movie(title: "하나 그리고 둘"),
                            Movie(title: "투모로우"),
                            Movie(title: "반지의 제왕"),
                            Movie(title: "어벤져스")
    
    ]
    
    var body: some View {
        
        NavigationView {
            
            ScrollView {
                SectionHeaderView(text: "떠오로는 영화")
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(movieStructArray, id: \.id) { item in
                            NavigationLink {
                                SampleMovieView(movie: item)
                            } label: {
                                VStack {
                                    Image(systemName: "star.fill")
                                    Text(item.title)
                                }
                                .frame(height: 60)
                                .padding()
                                .background(Color.red)
                            }
                        }
                    }
                    .background(Color.brown)
                }
                
                SectionHeaderView(text: "최근 영화")
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(movieStructArray, id: \.id) { item in
                            NavigationLink {
                                SampleMovieView(movie: item)
                            } label: {
                                VStack {
                                    Image(systemName: "star.fill")
                                    Text(item.title)
                                }
                                .frame(height: 60)
                                .padding()
                                .background(Color.red)
                            }
                        }
                    }
                }
                
                SectionHeaderView(text: "명작 추천")
                ScrollView(.horizontal) {
                    LazyHStack(alignment: .center) {
                        ForEach(movieStructArray, id: \.id) { item in
                            NavigationLink {
                                SampleMovieView(movie: item)
                            } label: {
                                VStack {
                                    Image(systemName: "star.fill")
                                    Text(item.title)
                                }
                                .frame(height: 60)
                                .padding()
                                .background(Color.red)
                            }
                        }
                    }
                }
            }
            .navigationTitle("영화 목록")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("First ToolBar tapped")
                    } label: {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("첫번째 툴바 탭")
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("Second ToolBar tapped")
                    } label: {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("두번째 툴바 탭")
                        }
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        print("Third ToolBar tapped")
                    } label: {
                        VStack {
                            Image(systemName: "star.fill")
                            Text("세번째 툴바 탭")
                        }
                    }
                }
            }
            .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "검색하기")
            
        }
        
        
    }
    
}


struct SectionHeaderView: View {
    
    var text: String
    
    var body: some View {
        
        HStack {
            Text(text)
                .font(.headline)
                .foregroundStyle(Color.blue)
                .background(Color.yellow)
            Spacer()
        }
        .padding()
        .background(Color.mint)
    }
}




#Preview {
    NavStackView()
}
