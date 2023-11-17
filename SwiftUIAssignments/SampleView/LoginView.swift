//
//  LoginView.swift
//  SwiftUIAssignments
//
//  Created by Heedon on 2023/11/17.
//

import SwiftUI

struct LoginView: View {
    
    @State var defaultTextField = ""
    @State var isOn = true
    
    var buttonTextCondition: some View {
        return Text("회원가입")
            .padding()
            .font(.title)
            .foregroundStyle(Color.black)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
    }
    
    var body: some View {
        
        VStack {
            
            Text("JackFlix")
                .font(.largeTitle)
                .foregroundStyle(Color.red)
            
            Spacer()
            Spacer()
            
            VStack(spacing: 0) {
                CustomInputTextFieldView(promptText: "이메일 주소 또는 전화번호", text: $defaultTextField)
                CustomInputTextFieldView(promptText: "비밀번호", text: $defaultTextField)
                CustomInputTextFieldView(promptText: "닉네임", text: $defaultTextField)
                CustomInputTextFieldView(promptText: "위치", text: $defaultTextField)
                CustomInputTextFieldView(promptText: "추천 코드 입력", text: $defaultTextField)
                Button(action: {
                    print("회원가입 누름")
                }, label: {
                    buttonTextCondition
                })
            }
            .background(Color.black)
            
            Toggle(isOn: $isOn) {
                Text("추가 정보 입력")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                
            }
            .tint(Color.red)
            .padding()
            
            Spacer()
            Spacer()
            Spacer()
            
        }
        .frame(height: .infinity)
        .background(Color.black)
        
        
    }
}




#Preview {
    LoginView()
}

struct CustomInputTextFieldView: View {
    
    let promptText: String
    
    @Binding var text: String
    
    var body: some View {
        
        TextField("",
                  text: $text,
                  prompt: Text(promptText).foregroundStyle(Color.white)
        )
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.gray)
        )
        .foregroundStyle(Color.white)
        .padding()
    }
}
