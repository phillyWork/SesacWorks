//
//  WalletView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/22/23.
//

import SwiftUI

struct WalletView: View {
    
    @State private var isExpandable = false
        
    var body: some View {
        
        VStack {
            topTitle()
//            Spacer()
            cardSpace()
            Button("Animation On") {
                //animation 속성 같이 넣기 (변화 요소 넣기 with 효과, 딜레이 설정...)
                withAnimation(.bouncy) {        //modifier 요소 많음, 어떻게 동작하는지 파악정도
                    isExpandable = true
                }
            }
            Button("Animation Off") {
                withAnimation(.easeInOut.delay(1)) {
                    isExpandable = false
                }
            }
        }
        
    }
    
    func topTitle() -> some View {
        Text("Wallet")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: isExpandable ? .leading : .center)     //어떤 alignment 결정할 지 state 활용
//            .background(.yellow)    //Text 영역 움직임 한정 --> 영역을 넓혀서 Text의 alignment를 바꾸면서 animation 주기
        
            //닫기 버튼 overlay로 미리 구성, alpha = 0으로 줘서 숨기기
            .overlay(alignment: .trailing) {
                //메서드로 분리 구성
                topOverlayButton()
            }
            .padding()  //버튼과 Text 모두 padding 주기
    }
    
    //custom button 구성
    func topOverlayButton() -> some View {
        Button {
            
        } label: {
            Image(systemName: "plus")
                .foregroundStyle(.white)
                .padding()
                .background(.black, in: Circle())   //in: 어디에 담을지
        }
        //나타날 때/숨겨질 때 회전하면서 (버튼이 나타날 때는 더 많이 돌아가도록)
        .rotationEffect(.degrees(isExpandable ? 225: 45))
        .opacity(isExpandable ? 1 : 0)
    }
    
    func cardSpace() -> some View {
        ScrollView {
            ForEach(0..<5) { item in
                cardView()
            }
        }
    }
    
    func cardView() -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.random())
            .frame(height: 150) //고정 크기 갖도록
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            //위쪽으로 옮겨서 겹쳐있는 것처럼 만들기
            //각 카드마다 올라와야하는 값이 달라져야 함
            .offset()
    }
    
}

#Preview {
    WalletView()
}
