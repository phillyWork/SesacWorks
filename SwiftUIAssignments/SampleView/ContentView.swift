//
//  ContentView.swift
//  SwiftUIAssignments
//
//  Created by Heedon on 2023/11/17.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresentable = false
    
    var body: some View {
            
        VStack {
            
            HStack(spacing: 20) {
                Text("N")
                    .font(.largeTitle)
                Text("TV 프로그램")
                    .font(.headline)
                Text("영화")
                    .font(.headline)
                Text("내가 찜한 콘텐츠")
                    .font(.headline)
            }
            .foregroundStyle(Color.white)
            
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            
            HStack(spacing: 50) {
                Button(action: {
                    print("내가 찜한 컨텐츠")
                }, label: {
                    VStack {
                        Image(systemName: "checkmark")
                        Text("내가 찜한 컨텐츠")
                    }
                })
                .foregroundStyle(Color.white)
                
                Button(action: {
                    isPresentable = true
                }, label: {
                    HStack(spacing: 0) {
                        Image(systemName: "star.fill")
                        Text("재생")
                            .font(.system(.title3))
                    }
                })
                .border(Color.white)
                .foregroundStyle(Color.black)
                .background(Color.white)
                
                Button(action: {
                    print("정보 info")
                }, label: {
                    VStack {
                        Image(systemName: "star.fill")
                        Text("정보")
                    }
                })
                .foregroundStyle(Color.white)
            }
            .padding()
            
            Spacer()
            
            HStack(spacing: 10, content: {
                Circle()
                    .fill(Color.white)
                Circle()
                    .fill(Color.white)
                Circle()
                    .fill(Color.white)
            })
            
        }
        .frame(width: .infinity)
        .background(Color.black)
        .sheet(isPresented: $isPresentable, content: {
            LoginView()
        })
        
    }
        
}

#Preview {
    ContentView()
}
