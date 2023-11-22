//
//  WalletDetailView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/22/23.
//

import SwiftUI

struct WalletDetailView: View {
    
    //화면 전환 관련 overlay 설정 (화면 dismiss, overlay false)
    @Binding var showDetail: Bool
     
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()        //safeArea 무시하고 전체 채우기
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.random())
                    .frame(height: 150)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        withAnimation {
                            showDetail = false
                        }
                    }
                Text("Hello, World!")
                Spacer()
            }
        }
    }
    
}

#Preview {
    WalletDetailView(showDetail: .constant(true))
}
