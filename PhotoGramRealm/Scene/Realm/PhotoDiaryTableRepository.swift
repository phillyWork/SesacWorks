//
//  PhotoDiaryTableRepository.swift
//  PhotoGramRealm
//
//  Created by Heedon on 2023/09/06.
//

import Foundation
import RealmSwift

//repository pattern 활용
//계층화 통해 어떤 목적, 어떤 기술 사용하는지 숨기기

//여러 table 활용: protocol로 공통 작업 정의
protocol PhotoDiaryRepositoryType: AnyObject {
    func fetch() -> Results<PhotoDiaryTable>
    func fetchFilter() -> Results<PhotoDiaryTable>
    func createItem(_ item: PhotoDiaryTable)
}

//with Generic 활용
protocol TableRepository: AnyObject {
    func fetch<T>() -> Results<T>
    func fetchFilter<T>() -> Results<T>
    func createItem<T>(_ item: T)
}

//realm 관련 작업 코드들 메서드화
//protocol 채택하기
class PhotoDiaryTableRepository: PhotoDiaryRepositoryType {
    
    //반복되는 경로 탐색 코드
    //외부에서 호출할 일 없음
    private let realm = try! Realm()
    
    private func a() {  //다른 파일에서 쓸 일 없음, 클래스 안에서만 사용 가능 --> override 불가능
        
    }
    
    //realm의 file 경로 확인
    func realmPath() -> URL? {
        guard let filePath = realm.configuration.fileURL else { return nil }
        print("filePath: \(filePath)")
        return filePath
    }
    
    //table version 체크
    func checkSchemaVersion() {
        do {
            if let filePath = realmPath() {
                let version = try schemaVersionAtURL(filePath)
                print("Schema Version: \(version)")
            }
            
        } catch {
            print(error)
        }
    }

    //MARK: - CREATE
    
    //parameter로 받기
    //1. record 자체
    //2. 또는 data만 받기
    func createItem(_ item: PhotoDiaryTable) {
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    //MARK: - READ
    
    func fetch() -> Results<PhotoDiaryTable> {
        let data = realm.objects(PhotoDiaryTable.self).sorted(byKeyPath: "diaryTitle", ascending: false)
        return data
    }
    
    
    //여러 filter 활용
    //1. enum type 매개변수로 각 filter 분기
    //2. 메서드로 명확하게 구분
    func fetchFilter() -> Results<PhotoDiaryTable> {
//        let results = realm.objects(PhotoDiaryTable.self).where { $0.diaryPhoto != nil }
        
        //filter도 어차피 fetch 후 작업
        
        //diaryPhoto --> photo로 이름 변경
        let results = fetch().where { $0.photo != nil }
        
        return results
    }
    
    
    //MARK: - UPDATE
    
    //parameter 받기
    //1. 바뀐 record
    //2. 바뀐 data만
    func updateItem(id: ObjectId, title: String, contents: String) {
        do {
            try realm.write {
                realm.create(PhotoDiaryTable.self, value: ["_id": id, "diaryTitle": title, "diaryContents": contents], update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    //MARK: - DELETE
    
    func delete() {
        
    }
    
}
