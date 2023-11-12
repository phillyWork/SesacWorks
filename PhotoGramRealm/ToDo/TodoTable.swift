//
//  TodoTable.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/08.
//

import Foundation
import RealmSwift

class TodoTable: Object {
    
    //Primary Key 안쓴다고 오류 발생하지는 않음
    //수정, 삭제 기능 구현 시 table/record 탐색 기준 역할
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title: String
    @Persisted var favorite: Bool
    
    //TodoTable 연관 설정: table이 또 다른 table을 가짐 (like Codable 구조체)
    //To Many Relationships (여러 Table 연결 가능)
    //빈 배열로 볼 수 있음 (optional 없어도 okay)
    
    //결국 column 추가: migration 필요
    @Persisted var detail: List<DetailTodoTable>
    

    //MemoTable 하나만 연결
    //To One Relationship: EmbeddedObject, 별도 테이블 생성되는 형태 아님
    
    //그냥 column 따로 만들어도 okay
    //존재 안할수도 있으므로 optional 필수
    
    //결국 column 추가: migration 필요
    @Persisted var memo: MemoTable?
    
    convenience init(title: String, favorite: Bool) {
        self.init()
        self.title = title
        self.favorite = favorite
    }
    
}

//Todo 내 세부 항목 역할
class DetailTodoTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var detail: String
    @Persisted var deadline: Date
    
    //DetailTodoTable로 상위 TodoTable에 접근하려는 경우
    //Inverse Relationship Property (LinkingObjects)
    //TodoTable 어디에 속해있는지 알려주기: List 구조로 연관되어 있는 경우만 가능 (detail: TodoTable의 detail)
    @Persisted(originProperty: "detail") var mainTodo: LinkingObjects<TodoTable>
    
    convenience init(detail: String, deadline: Date) {
        self.init()
        self.detail = detail
        self.deadline = deadline
    }
}


//1:1 관계, 안에 속하는 것 --> 특정 column에 들어가기
class MemoTable: EmbeddedObject {
    @Persisted var content: String
    @Persisted var date: Date
    
    //Memo에서도 TodoTable 어디에 속해있는지 알 수 있음 (가능 O, 잘 쓰지는 않음)
}
