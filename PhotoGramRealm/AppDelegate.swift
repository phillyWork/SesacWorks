//
//  AppDelegate.swift
//  PhotoGramRealm
//
//  Created by jack on 2023/09/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        //mainView 진입 전 migration 설정하기
        //column, table 단순 추가/삭제: realm에서 automatic으로 대응, version만 설정하면 okay
        let config = Realm.Configuration(schemaVersion: 7) { migration, oldSchemaVersion in
            //oldSchemaVersion: 현재 사용자 쓰는 버전
            //한번에 올리지 않고, 한 단계씩 올려줌 (0 -> 7 : 0 -> 1, 1 -> 2, ...)
            
            //각 version마다 어떻게 변했는지 주석 처리 (realm에서 automatic하게 해줌
            if oldSchemaVersion < 1 { }     //diaryPin column 추가
            
            if oldSchemaVersion < 2 { }     //diaryPin column 삭제
            
            //column 수정: 따로 입력해줘야 함
            if oldSchemaVersion < 3 {       //diaryPhoto --> photo로 column 이름 변경
                migration.renameProperty(onType: PhotoDiaryTable.className(), from: "diaryPhoto", to: "photo")
            }
            
            //수정 내용 입력 없음: 단순 제거/추가로 인식 (diaryContents 삭제, contents 추가)
            //기존 data 사라짐
            //diaryContents --> contents로 column 이름 변경
            if oldSchemaVersion < 4 { }
            
            //기존 column 조합해서 새로운 column 추가 (version 5)
            if oldSchemaVersion < 5 {       //diarySummary column 추가, title과 contents 내용 합쳐서 넣기
                migration.enumerateObjects(ofType: PhotoDiaryTable.className()) { oldObject, newObject in
                    guard let new = newObject, let old = oldObject else { return }
                    new["diarySummary"] = "제목은 '\(old["diaryTitle"])'이고, 내용은 '\(old["contents"] ?? "")'입니다"
                }
            }
            
            if oldSchemaVersion < 6 { }     //Todo Table 내 DeatilTodo table을 property로 가짐
            
            if oldSchemaVersion < 7 { }     //Todo Table 내 Memotable를 property로 가짐
            
        }
        
        Realm.Configuration.defaultConfiguration = config

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

