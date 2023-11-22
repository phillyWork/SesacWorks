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
    
    //WalletView에서 선택한 카드 데이터 (변경할 요인 없음)
    let currentWallet: WalletModel
     
    //상위 view에서 전달해온 namespace (동일 group 인식 목적)
    var animation: Namespace.ID
    
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()        //safeArea 무시하고 전체 채우기
            VStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(currentWallet.color)
                    .frame(height: 150)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .onTapGesture {
                        withAnimation {
                            showDetail = false
                        }
                    }
                    .matchedGeometryEffect(id: currentWallet.id, in: animation)     //탭한 detailView와 일치하도록 설정 --> 동일 view로 전환 애니메이션 적용됨
                Text(currentWallet.name)
                Spacer()
            }
        }
    }
    
}

//#Preview {
//    WalletDetailView(showDetail: .constant(true))
//}
