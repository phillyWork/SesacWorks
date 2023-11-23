//
//  RenderView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/13.
//

import SwiftUI

//View가 그려지는 과정 확인
struct RenderView: View {

    //fullScreenCover: dismiss 요소 필요
    
    //Environment property wrapper
    
    //모든 view에 공통적으로 가지는 특성
    //system에서 정의된 값 감지 --> view update에 활용
    
    //keypath로 구성: \으로 구성
    //괄호 안 요소: EnvironmentValue
    
    //deprecated 예정
//    @Environment(\.presentationMode) var presentationMode
    
    //명시적으로 사라질 것 의미
    @Environment(\.dismiss) var dismiss
    
    //light mode, dark mode 대응용 --> system 설정값 전달받아서 활용
    @Environment(\.colorScheme) var colorScheme
    
    
    //struct 내부 prooperty 변화: @State 활용
    @State var age = 10

    //init 확인
    init(age: Int = 10) {
        self.age = age
        print("RenderView init")
    }
    
    //연산 프로퍼티처럼 따로 빼기
    var bran: some View {
        Text("Bran: \(Int.random(in: 1...100))")
    }
        
    var body: some View {
        
        //push, pop 구현
        //NavigationView & NavigationStack 활용
        //실제작업: Button 대신 NavigationLink 활용
        
        //NavigationView 없이 NavigationLink 설정: 버튼 활성화 시작부터 막힘
        
        NavigationView {
            
            VStack {
                
                //Gradation 적용
                HStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            //Gradient View 활용
                            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.blue]), startPoint: .bottomLeading, endPoint: .trailing)
                        )
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            //center: 시작 위치
                            //startRadius: 시작 원 반지름
                            //endRadius: 끝나는 원 반지름
                            RadialGradient(gradient: Gradient(colors: [Color.red, Color.green]), center: .topLeading, startRadius: 30, endRadius: 60)
                        )
                    
                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            AngularGradient.init(gradient: Gradient(colors: [Color.purple, Color.yellow]), center: .leading, angle: .degrees(200))
                        )
                    
                }
                .frame(width: .infinity, height: 100)   //infinity: 사용할 수 있는 만큼 다 활용
                .padding()
                
                
                //Button: 단순 클릭/탭
                //Push 화면 전환: NavigationLink
                
                //Q) data 전달?
                NavigationLink("Push") {
                    MenuView()
                }
                
                
                

                Text("Hue: \(age), \(Int.random(in: 1...100))")
                Text("Jack: \(Int.random(in: 1...100))")
                bran
                kokoView()
                
                Button(colorScheme == .dark ? "다크모드 클릭" : "라이트모드 클릭") {
                    //data 변화 주기
                    //age가 변화: age만 그대로?
//                    age = Int.random(in: 1...100)
                    
                    //실제 변화: subview로 분리한 koko 제외 버튼 눌릴때마다 다 변화함
                    //body가 새롭게 계속 그려짐
                    
                    
                    //Environment 활용: dismiss 구현
                    //(pop, dismiss 방식 구분하지 않음, 사라질 수 있다면 사라지기)

                    //deprecated 예정
//                    presentationMode.wrappedValue.dismiss()
                    
                    //함수처럼 호출
                    dismiss.callAsFunction()
                }
                //Envrionment 활용 ~ system 라이트/다크모드따라서 설정 가능
                .background(colorScheme == .dark ? .black : .gray)
                .foregroundStyle(colorScheme == .dark ? .white : .yellow)
                
            }
            .navigationTitle("네이게이션 타이틀")   //NavBar의 Title 설정
            .navigationBarItems(leading: Text("BarItem"))
        }
        
    }
}

#Preview {
    RenderView()
}

//subview로 분리
struct kokoView: View {
    var body: some View {
        Text("Koko: \(Int.random(in: 1...100))")
    }
}
