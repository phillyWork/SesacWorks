//
//  OverlayView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/21/23.
//

import SwiftUI

//Test for Overlay

struct OverlayView: View {
    var body: some View {
            
        VStack {
            
            //Zstack으로 Text를 위에 올리기
            //Zstack 내부 각 View: 별도
            //size 설정도 다 각자
            ZStack {
                Circle()
                    .fill(.yellow)
                    .frame(width: 150, height: 150)
                Text("안녕하세요 감사해요 잘있어요 다시만나요")
            }
            
            //Overlay로 Text를 위에 올리기
            //addSubView처럼 Circle 내부 Text: Circle 벗어나지 않음
            Circle()
                .fill(.yellow)
                .frame(width: 150, height: 150)
                .overlay {
                    Text("안녕하세요 감사해요 잘있어요 다시만나요")
                }
                
        }
        
    }
}

#Preview {
    OverlayView()
}
