//
//  CategoryViewSecond.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/15.
//

import SwiftUI

struct PosterView: View {
    
    var body: some View {
        
        //default: vertical scroll
        ScrollView(showsIndicators: true) {

//            VStack {
            
            //LazyVStack vs. VStack
            //LazyVStack: 기본으로 infinity 설정

            //최적화 차이 (어느 정도의 contents 양인지, 스크롤 정도에 따라)
            //일반 Stack: 설정 외부 영역도 다 미리 load
            //lazy Stack: 재사용 메커니즘 활용 ~ 보여지는 부분만 load (스크롤 양이 많거나, 서버에서 불러올 이미지/영상이 많은 경우...)
            
            //List: lazy 특성 기본으로 내장
            
            
            LazyVStack {
                //결국 ForEach도 각 View 생성 반복하는 것
                ForEach(0..<50) { item in
                    Text("안녕하세yo \(item)")
                        .lineLimit(2)
                }
            }
            //default: contentSize만큼만 scroll
            //가로 화면 꽉 차도록 scroll contentsView 설정해놓기 (scroll indicator 오른쪽 위치)
//            .frame(maxWidth: .infinity)
        }
        .background(Color.orange)
//        .contentMargins(10, for: .scrollContent)       //content margin 영역 설정 (상하좌우)
//        .contentMargins(50, for: .scrollIndicators)     //indicator margin 영역 설정
    }
    
}


//Text영역에 View 가져다 활용

//AsyncImage 객체 (iOS 15)
//그 전: image url 통신으로 가져와서 구성 (with Kingfisher, URLSession)

struct AsyncImageView: View {
   
    let url = URL(string: "https://picsum.photoㄴㄴs/400")
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .scaledToFit()
                .frame(width: 140, height: 100)
            //이미지 가공 고려
//                .scaledToFill()

//                .cornerRadius(10) //deprecated
                .clipShape(RoundedRectangle(cornerRadius: 10))
        } placeholder: {
            //이미지 load 과정에서의 처리
//            Image(systemName: "star")
            
            //loading indicator로 적용하기
            ProgressView()
            
            //문제: url이 잘못되면 무한 loading으로 멈춤
        }

    }
    
}

struct AsyncImageViewSecond: View {
   
    let url = URL(string: "https://picsum.photoㄴㄴs/400")
    
    var body: some View {
        //해결: AsyncImagePage 활용
        //분기 처리 가능
        AsyncImage(url: url) { data in
            switch data {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .scaledToFit()
                    .frame(width: 250, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            case .failure(_):
                //error 활용하지 않으면 let까지 생략 --> wildcard로만 나타내기
                //실패했을 때의 설정
                Image(systemName: "star")
            @unknown default:
                //이후 버전 업데이트로 케이스 추가될 경우 대비 (아직 frozen 설정되어있지 않음)
                Image(systemName: "star")
            }
        }
    }
}


#Preview {
//    PosterView()
//    AsyncImageView()
    AsyncImageViewSecond()
}
