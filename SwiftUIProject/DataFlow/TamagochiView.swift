//
//  TamagochiView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/14.
//

import SwiftUI

//struct 내 method & property로 값 변화 비교
struct User {
    var nickname = "고래밥"
    
    //연산 property:
    var introduce: String {
        //get으로 변경: mutating 활용
        mutating get {
            nickname = "칙촉"
            return "안녕하세요 \(nickname)입니다"
        }
    }
    
    //메서드: mutating 필요
    mutating func changeNickname() {
        nickname = "칙촉"
    }
}



struct TamagochiView: View {
    
    //data가 state 가짐: Source of Truth (SOT)
    //view는 바뀐 data로 화면에 그려줌
    
    //view 상태 저장 목적 (state property)
    //속한 view의 상태만 관리 목적 --> private 설정 권장
    //달라지는 data로 body render
    @State private var waterCount = 0
    
    @State private var riceCount = 0
    
    @State private var isOn = false
    
    @State private var textFieldInput = ""
    
    //body: computed property
    //값 변화: get 내부에서 작동 --> 수정하려면 mutating get 필요
    
    //에러: View protocol 채택하고 있지 않음
    //View protocol은 Body를 get으로 필수 규정
    //mutating get 못씀, 필수 요구사항 깨지는 것 방지
    
    //해결: @State property wrapper 활용
    
    var body: some View {
        
//        mutating get {
            
            VStack {
                
                //TextField 입력값 매번 변화, State로 보유해야 고유하게 구분 가능
                //전달 받기: $로 Binding값 받기
                TextField("물방울 갯수 입력하기", text: $textFieldInput)
//                    .padding()
                
                //각 UI component: 결국 전체 view의 하위 view 역할
                //관리하는 @state data 전달받아서 변화 시, 다시 원본에 전달하기
                Toggle("스위치", isOn: $isOn)
//                    .padding()
                
                ExtractedView(text: "물방울", count: $waterCount)
                
                Button("물방울 늘리기") {
                    
                    //Button tap: nickname 값 변경하기
                    waterCount += 1
                    
                    //버튼 탭마다 switch 왔다갔다하기
                    isOn.toggle()
                    
                    //UIKit: data 변경 ~ view에 다시 반영해주는 코드 필요
                    //SwiftUI: data 변화 --> view update 신호 --> view render
                    //기준점: @State
                    
                }
                .padding(50)      //size 조정
                .background(.orange)
                
                //State로 값 관리: 고유한 data
                //ExtractedView: SubView
                
                //State와 SubView 관리하는 data 항상 일치해야 하는 경우: State와 binding 필요
                //State의 data 고유하게 관리하도록 함
                
                ExtractedView(text: "밥알", count: $riceCount)
                
                //Button action lable 활용 (View 그 자체, 커스텀 활용 많이 가능)
                Button(action: {
                    riceCount += 1
                    
                    //버튼 탭마다 switch 왔다갔다하기
                    isOn.toggle()
                    
                }, label: {
                    Text("밥알 늘리기")
                        .padding(50)
                        .background(.orange)
                })
                //button 자체에 padding: label 영역만 tap 가능 (view만 커짐)
                //label에 padding 주고 활용: 버튼 전체 영역 tap 가능
                
            }
            .padding()  //속한 모든 view에 공통 적용: Stack에 modifier 적용하기
        
           
            
//        }
        
    }
}

#Preview {
    TamagochiView()
}


//subview로 분리


struct ExtractedView: View {
    
    let text: String

    //property로 초기화해서 활용 (표현만 할 경우, read만 해올 경우)
    
    //값 변화: @State 달기 --> 상위 view의 data와 일치하지 않는 상황 발생 가능
    //state 별도 처리 --> 같은 데이터로 보지 않으므로 상위 view의 버튼 동작하지 않음
//    @State var count: Int

    //@State: 오로지 속한 View의 고유 data 관리 목적
    
    //상위 view에서 전달하는 data 받아서 전달하기
    //State와 바인딩해서 활용: State에서 관리하는 데이터 고유하도록 함
    //Binding 활용: @State의 데이터 참조, 데이터 일치하도록 함
    //Derived data
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text("누적 \(text): \(count)개")
                .background(.black)
                .foregroundStyle(Color.white)
                .font(.title)
            
            Button("subView 버튼") {
                count += 1
            }
            
        }
    }
}
