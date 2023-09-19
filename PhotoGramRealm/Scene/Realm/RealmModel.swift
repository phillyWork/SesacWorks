//
//  RealmModel.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/04.
//

import Foundation
import RealmSwift

//table 구조
//e.g.) ID(중복 기록 구분용), 제목, 날짜, 내용, 사진 url

class PhotoDiaryTable: Object {
    
    //PK 설정은 primaryKey만 설정하면 되는 것 (무조건 id가 PK여야 하는 것 아님)
    
    @Persisted(primaryKey: true) var _id: ObjectId                    //id: PK (ObjectId로 Realm에서 내부적으로 제공해줌, 따로 init할 필요 없음)
    @Persisted var diaryTitle: String = ""                            //일기 제목: 필수
    @Persisted var diaryDate: Date                                    //등록 날짜: 필수
    @Persisted var contents: String?                             //일기 내용: 옵션
    @Persisted var photo: String?                             //사진 url: 옵션
    @Persisted var diaryLike: Bool                                  //즐겨찾기 기능: 필수
    
    //migration 목적: 새로 property/column 추가
    //추가 후 다시 삭제 (schemaVersion: 2로 될 것)
//    @Persisted var diaryPin: Bool
    
    
    //diaryPhoto --> photo로 column 이름 변경
    //schemaVersion 올리기 (version 3)
    
    //diaryContents --> contents로 column 이름 변경
    //schemaVersion 올리기 (version 4)
    
    
    //기존 column 내용 추가해서 새로운 column 만들기 (version 5)
    @Persisted var diarySummary: String
    
    
//    init(diaryTitle: String, diaryDate: Date, diaryContents: String?, diaryPhotoURL: String?) {
//        super.init()
//        self.diaryTitle = diaryTitle
//        self.diaryDate = diaryDate
//        self.diaryContents = diaryContents
//        self.diaryPhotoURL = diaryPhotoURL
//    }
    
    //ObjectId 활용: 따로 init할 필요 없음
    //편의 생성자 활용
    convenience init(diaryTitle: String, diaryDate: Date, diaryContents: String?, diaryPhoto: String?) {
        self.init()
        self.diaryTitle = diaryTitle
        self.diaryDate = diaryDate
        self.contents = diaryContents
        self.photo = diaryPhoto
        self.diaryLike = true
        self.diarySummary = "제목은 '\(diaryTitle)'이고, 내용은 '\(diaryContents ?? "")'입니다"
    }

    
}



