//
//  WalletView.swift
//  SwiftUICoinOrderBook
//
//  Created by Heedon on 11/22/23.
//

import SwiftUI

struct WalletView: View {
    
    //값 변화 --> body 다시 그림
    @State private var isExpandable = false     //animation 효과
    @State private var showDetail = false       //다음 화면 전환
        
    let wallet = walletList      //dummy data 모음집: 전역변수와 겹칠 수 있음 (이름 설정 고려, 변경 없으므로 let만)

    @State private var selectedWallet = WalletModel(name: "", index: 0)          //현재 탭한 카드 정보
    
    //group 정보 목적 설명용
    //다른 data는 각자 인식될 수 있도록 해야 함: id 역할
    @Namespace var animation
    
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
        //overlay로 다음 화면 구성
        .overlay {
            //if 조건 없이 overlay만 구성: 바로 instance 생성
            //overlay 여부 결정하는 State Binding에 전달하기
            
            //해당 카드의 정보 전달 필요
            if showDetail {
                WalletDetailView(showDetail: $showDetail,
                                 currentWallet: selectedWallet,
                                animation: animation)
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
            //버튼 누르면 다시 모아지기 withAnimation
            withAnimation {
                isExpandable = false
            }
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
            //구조체 기반 dummy data 활용 (같은 카드 다루고 있음 알리기)
            ForEach(wallet, id: \.self) { item in
                //개별 cardView마다 offset 다르게 설정
//                cardView(index: item)
                cardView(item)
            }
        }
        //카드 내용이 많아지면 scroll 필요 --> 다른 방식으로 구성해야할 필요 O
        .overlay {  //tapGesture 대응용 투명 사각형 위에 올려놓기
            Rectangle()
                .fill(.black.opacity(isExpandable ? 0 : 0.01))      //0.01: 애플 문서 기준 탭 인식 최소값
                                                                    //탭해서 펼쳐진 상태: 사각형 탭 인식되지 않도록 하기 (0)
                .onTapGesture {
                    withAnimation {             //빈 영역 포함 카드 탭: 넓어지도록 하기
                        isExpandable = true
                    }
                }
        }
    }
    
    //index 대신 data 자체로 담기
//    func cardView(index: Int) -> some View {
    func cardView(_ data : WalletModel) -> some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(data.color)
            .frame(height: 150) //고정 크기 갖도록
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            //위쪽으로 옮겨서 겹쳐있는 것처럼 만들기
            //각 카드마다 올라와야하는 값이 달라져야 함
            //동일 간격으로 계산: 곱셉으로 구성
        
            //곱셈 값을 animation 여부 값에 따라 다르게 구성
            //default: 단순 ScrollView --> 접혀있는 식으로 보여주다 true가 되면 원래 default로 나타나도록 하기
            .offset(y: CGFloat(data.index) * (isExpandable ? 0 : -130))
            .onTapGesture {
                //탭을 통해 모여있을 때 풀어지도록 하기
                withAnimation(.spring) {
                    //isExpandable을 true를 주면 body 다시 그림 --> showDetail 바로 true로 바꿈 --> body 다시 그림 --> overlay 적용
                    //해결: 투명 view 하나 올려서 tapGesture 대응하기
                    
                    //카드 영역 직접 tap: 다음 화면으로 넘어가기
                    showDetail = true
                    
                    //선택 카드 정보도 전달 필요함 (State var 활용)
                    //data 변경 --> body 다시 그림
                    selectedWallet = data
                }
            }
            //data 정보 값 일치하면 group화 (서로 다른 위치의 view 동일하도록 인식하게 함)
            //Namespace: group화 용도
            //id 말고 data 그 자체를 전달해도 okay
            .matchedGeometryEffect(id: data.id, in: animation)
//            .matchedGeometryEffect(id: data, in: animation)
    }
    
}

#Preview {
    WalletView()
}
