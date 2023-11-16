//
//  SearchView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/16.
//

import SwiftUI

//분리 --> rendering 차이점 확인

struct SearchView: View {
    
    @State var randomNumber = 0
    
    //property 별도 값 지정하지 않으면 init에서 초기화값 받아와야 함
    init(randomNumber: Int = 0) {
        self.randomNumber = randomNumber
        print("SearchView init")
    }
    
    //data 변화 --> body를 다시 그림
    //modifier 적용도 다시 함
    
    //예외: SubView --> 한번 정해지면 body 다시 그려도 영향받지 않음
    
    var body: some View {
        
        VStack {
            
            //1. SubView로 분리
            //SearchView는 처음 init
            //Body는 매번 다시 그리지만, HueView instance는 매번 새로 init됨
            HueView()
            
            //2. Property로 분리
            jackView
            
            //3. Method로 분리
            KokoView()
            
            
            Text("Bran \(randomNumber)")
                .background(Color.random())
        
            //State의 변수 추적, 클릭할 때마다 다른 값으로 update
            Button("클릭") {
                randomNumber = Int.random(in: 1...100)
            }
            
        }
        
    }
    
    
    var jackView: some View {
        Text("Jack")
            .background(Color.random())
    }
    
    
    func KokoView() -> some View {
        Text("Koko")
            .background(Color.random())
    }
    
    
}

#Preview {
    SearchView()
}



struct HueView: View {
    
    init() {
        print("HueView init")
    }
    
    //body와 init은 별개
    //SubView의 body가 변화 없다면 다시 그리지 않음
    
    //SubView는 상위 view의 body가 다시 그리면 instance 새로 생성 --> init 호촐됨
    
    //if) SubView의 init에 네트워크 통신 구현: UI적으로 변화 없어도 init 매번 호출되어 통신 과호출 우려 발생
    var body: some View {
        Text("Hue")
            .background(Color.random())
    }
}


extension Color {
    
    static func random() -> Color {
        return Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
    }
    
}
