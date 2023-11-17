//
//  SearchView.swift
//  SwiftUIProject
//
//  Created by Heedon on 2023/11/16.
//

import SwiftUI

//분리 --> rendering 차이점 확인

//struct SearchView: View {
//
//    @State var randomNumber = 0
//
//    //property 별도 값 지정하지 않으면 init에서 초기화값 받아와야 함
//    init(randomNumber: Int = 0) {
//        self.randomNumber = randomNumber
//        print("SearchView init")
//    }
//
//    //data 변화 --> body를 다시 그림
//    //modifier 적용도 다시 함
//
//    //예외: SubView --> 한번 정해지면 body 다시 그려도 영향받지 않음
//
//    var body: some View {
//
//        VStack {
//
//            //1. SubView로 분리
//            //SearchView는 처음 init
//            //Body는 매번 다시 그리지만, HueView instance는 매번 새로 init됨
//            HueView()
//
//            //2. Property로 분리
//            jackView
//
//            //3. Method로 분리
//            KokoView()
//
//
//            Text("Bran \(randomNumber)")
//                .background(Color.random())
//
//            //State의 변수 추적, 클릭할 때마다 다른 값으로 update
//            Button("클릭") {
//                randomNumber = Int.random(in: 1...100)
//            }
//
//        }
//
//    }
//
//
//    var jackView: some View {
//        Text("Jack")
//            .background(Color.random())
//    }
//
//
//    func KokoView() -> some View {
//        Text("Koko")
//            .background(Color.random())
//    }
//
//
//}


//ForEach 고유성 확보
struct Movie: Hashable, Identifiable {
    let id = UUID()
    let title: String
    let color = Color.random()
    //수치 표현 데이터
    let count = Int.random(in: 1...100)
}



//검색 기능
struct SearchView: View {
    
    @State private var searchQuery = ""
    
    @State private var showChart = false
    
    //    let movieArray = ["ABC", "AB", "BCD", "BEF", "아이언맨", "엑스맨", "해리포터", "헬로우"]
    
    //구조체 모델로 확장
    let movieStructArray = [Movie(title: "어벤져스"), 
                            Movie(title: "AB"),
                            Movie(title: "BCD"),
                            Movie(title: "BEF"), 
                            Movie(title: "아이언맨"),
                            Movie(title: "엑스맨"),
                            Movie(title: "해리포터"),
                            Movie(title: "엔드게임")]
    
    //검색된 결과 보여줄 데이터 따로 구성 (원본: 전체 데이터 보여주기에 활용)
    var filterMovie: [Movie] {
        //@State인 searchQuery 기준으로 처리
        //검색어 없다면 전체 데이터, 검색어 존재하면 filter하기
        return searchQuery.isEmpty ? movieStructArray : movieStructArray.filter { $0.title.contains(searchQuery)}
    }
    
    
    //searchQuery 변경될 때마다 body를 새로 그림
    var body: some View {
        
        //iOS 16 이상부터만 사용 가능
        //NavLink의 instance init이 매번 되는 문제 해결
        
        //NavigationLink: value & label --> NavigationStack
        //NavigationLink: destination & label --> NavigationView
        NavigationStack {
//        NavigationView {
            
            //textField 비밀번호 구성
//            SecureField(<#T##titleKey: LocalizedStringKey##LocalizedStringKey#>, text: <#T##Binding<String>#>)
            
            //어떤 stack에 어떤 data 넣을지 결정
            
            //TableView처럼 처리
            List {
//            LazyVStack {
                //Hstack 반복된 형태로 만들기 (element 개수만큼 처리)
//                ForEach(movieArray, id: \.self) { item in
                
//                ForEach(movieStructArray, id: \.self) { item in
//                ForEach(movieStructArray, id: \.id) { item in

                //filter된 데이터로 처리하기
                ForEach(filterMovie, id: \.id) { item in
                    //해당 버튼 클릭 --> 다음 링크로 넘어가기
                    //action label 활용
                    //label: text 제외 다른 view들 (custom initializer)
                    
                    //NavigationView용 NavigationLink
//                    NavigationLink {
//                        //어디로 보내주지 instance 생성
//                        //data 전달하기 by initializer
//                        
//                        //문제: 계속해서 init이 됨
//                        //wrapping할 필요성 있음 --> View로 묶기
//                        
//                        SearchDetailView(movie: item)
//                    } label: {
//                        //무엇이 넘어갈 지 설정
//                        HStack {
//                            Circle()
//                                .foregroundStyle(item.color)
////                        Text("\(item)")   //movieArray인 경우
//                            Text("\(item.title)")
//                        }
//                        .frame(height: 60)
//                    }
                    
                    
                    //NavigationStack용 NavigationLink
                    //value 기반 ~ data를 기준으로 넘겨주기
                    NavigationLink(value: item) {
                        //눌릴 NavigationLink 화면(UI) 구성
                        HStack {
                            Circle()
                                .foregroundStyle(item.color)
                            Text("\(item.title)")
                        }
                        .frame(height: 60)
                    }
                    
                }
            }
//            .frame(width: 200, height: 60)
            .navigationTitle("검색")
            .navigationBarTitleDisplayMode(.inline)
            
//            //deprecated
//            .navigationBarItems(leading: <#T##View#>, trailing: <#T##View#>)
            
            //toolbar 활용: nav bar 밑 tabbar, keyboard 등 활용 가능
            .toolbar {
                //위치 설정 필요
                ToolbarItemGroup(placement: .keyboard) {
                    //keyboard 위 button 구성
                    Button {
                        print("nav bar tapped")
                    } label: {
                        Image(systemName: "star.fill")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarLeading) {
                    //nav bar leading 영역 button 구성
                    Button {
                        showChart = true
                    } label: {
                        Image(systemName: "star.fill")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    //nav bar trailing 영역 button 구성
                    Button {
                        print("nav bar tapped")
                    } label: {
                        Image(systemName: "person")
                    }
                }
                
            }
            
            //NavStack 활용 시:
            //목적지 설정: item을 for의 Hashable로 받음 (item의 type 설정)
            //Hashable로 item 넘겨줘서 다음 화면의 property로 넘겨줌
            .navigationDestination(for: Movie.self) { item in
                SearchDetailView(movie: item)
            }
           
        }
        //searchable이 navigationView에 붙어있다면 return view가 어디 위치인지 확인 필요
        //List에 붙이기
        
        //따로 searchBar가 존재하지 않음
        //Binding 필요 ~ State 매개변수 필요
        //placement: navigationView 바로 밑
        //prompt: placeholder 역할
        .searchable(text: $searchQuery, placement: .navigationBarDrawer, prompt: "검색해보세요.")
        //enter key 눌렀을 때의 completionHandler 처리
        .onSubmit(of: .search) {
            print("fhfhfh")
        }
        
        //sheetPresentation으로 띄우기
        .sheet(isPresented: $showChart, content: {
            //화면전환하면서 값 같이 전달
            ChartView(movieData: movieStructArray)
        })
    }
    
}



struct SearchDetailView: View {

    //data 전달받아 수정해서 동기화 처리: state, binding 필수
    
    //단순 display 목적: state, binding 필요 없음
    let movie: Movie
    
    var body: some View {
        
        VStack {
            
            //전달받은 data 나타내기
            Text(movie.title)
            
            Toggle(isOn: /*@START_MENU_TOKEN@*/.constant(true)/*@END_MENU_TOKEN@*/, label: {
                /*@START_MENU_TOKEN@*/Text("Label")/*@END_MENU_TOKEN@*/
            })
            
            Text("Search Detail View")
            
            Button("기본 버튼") {
                print("asdfasdf")
            }
            
            //custom 영역 ~ label로 initializer 구성
            Button(action: {
                
            }, label: {
                HStack {
                    Circle()
                        .foregroundStyle(Color.red)
                    Text("Button")
                }
            })
            .frame(height: 60)
        }
        
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
