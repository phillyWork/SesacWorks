//
//  MenuView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/13.
//

import SwiftUI

struct MenuView: View {

    //property로 빼기: 이 View 내부에서만 활용하는 경우
    var cardProperty: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: "star.fill")
                .background(Color.red)
            Text("property 구분하기")
                .background(Color.green)
        }
        .padding()
        .background(Color.blue)
    }
    
    var body: some View {
        
        //Spacer(): 남은 영역 꽉 채움
        
        VStack {
            HStack(alignment: .center, spacing: 20) {
                
                //재사용 고려: subview로 빼기
                //서로 다른 data 전달해주기
                CardView(imageString: "globe", text: "토스 증권")
                CardView(imageString: "star", text: "토스 뱅크")
                CardView(imageString: "magnifyingglass", text: "토스 페이")
                //property로 변경 가능
                cardProperty
            }
            .padding()
            .background(Color.yellow)

            //TableView 역할
            List {
                //Section 구분 with Title
                Section("자산") {
                    Text("보안과 인증")
                         //modifier로 적용
                        .modifier(PointBoderderText())
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { Text("오늘의 날짜") })
                    Text("내 신용점수")
                        //custom modifier로 구성해서 활용 (동일 작업)
                        .asPointBorderText()
                    Text("진행 중인 이벤트")
                }
                Section("증권") {
                    ColorPicker("색깔 선택", selection: /*@START_MENU_TOKEN@*/.constant(.red)/*@END_MENU_TOKEN@*/)
                    Text("내 자산")
                        .modifier(PointBoderderText())
                    Text("송금")
                    Text("투자 모아보기")
                }
            }
            //TableView style 변화
            .listStyle(.grouped)
            
        }
        
    }
}

//Preview 기능 제공 (구조체 instance 통해서 제공)
#Preview {
    MenuView()
}

//instance로 customView처럼 활용
//별도 file로 분리해서 처리 가능
//다른 View에서도 활용 가능
struct CardView: View {
    
    //서로 다른 data값 전달받기
    let imageString: String
    let text: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(systemName: imageString)
                .background(Color.red)
            Text(text)
                .background(Color.green)
                .underline()
                .strikethrough()
        }
        .padding()
        .background(Color.blue)
    }
}


//subview 내부 modifier 여러 개 달아놓은 것 반복 --> 분리
//custom modifier 만들기
struct PointBoderderText: ViewModifier {

    //typealias말고 직접 func로 설정하기
//    typealias Body = <#type#>
    
    func body(content: Content) -> some View {
        //어떤 Content가 들어올 지 모르지만 들어오면 해당 modifier 적용하기
        content
            .font(.title)
            .padding(10)
            .foregroundStyle(.white)
            .background(.purple)
            .clipShape(.capsule)
    }
}


//Apple 권장 형태
//어차피 반환값: View
//한번 더 추상화

extension View {
    
    //modifier 미리 함수로 담기
    func asPointBorderText() -> some View {
        modifier(PointBoderderText())
    }
    
}

