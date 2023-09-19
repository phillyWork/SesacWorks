//
//  Endpoint.swift
//  SeSAC3Week5
//
//  Created by jack on 2023/08/14.
//

import Foundation
    
enum Nasa: String, CaseIterable {
    
    //static 활용 (type stored property)
    //compile time load: enum은 instance 생성 불가
    //enum: stored property 활용 X
    
    //static --> type property는 data 영역에 존재 --> instance 생성 및 initialization과 상관없음
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    
    //type computed property: stored property X
    //instance computed property는 활용 가능
    
    //실제 공간 차지하지 않음 (값 저장하지 않음)
    //값을 사용할 수 있는 통로로서의 역할만 담당, 저장 property를 활용할 수 있음
    var exampleUrl: URL {
        return URL(string: "https://www.naver.com")!
    }
    
    
    
    //static member allCases cannot be used on instance of type
    //안에서 활용하는 property가 static인 경우, static computed property만 활용 가능
    
    //instance stored property를 활용: instance computed property 활용
    
    //instance computed property로 활용하려는 경우, Nasa.allCases로 type property 활용 가능
    
    //instance property가 초기화하기 전, 만들어지기 전부터 type property는 존재하기 때문
    
    static var photo: URL {
        //allCases로 enum 제거 불가능, 왜 optional? --> randomElement 메서드는 array 영역 method, type 상관없이 optional return
        return URL(string: baseURL + self.allCases.randomElement()!.rawValue)!
    }
}
