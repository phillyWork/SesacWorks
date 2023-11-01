//
//  AppDelegate.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/08.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //schema version 확인
        let config = Realm.Configuration(schemaVersion: 3) { migration, oldSchemaVersion in
            
            if oldSchemaVersion < 0 {   //author --> mainAuthor
                migration.renameProperty(onType: BookTable.className(), from: "author", to: "mainAuthor")
            }
            
            if oldSchemaVersion < 1 {   //publishID ~ isbn + date
                migration.enumerateObjects(ofType: BookTable.className()) { oldObject, newObject in
                    guard let new = newObject, let old = oldObject else { return }
                    new["publishID"] = "\(old["isbn"]): \(old["date"])"
                }
            }
            
            if oldSchemaVersion < 2 {   //like --> heart
                migration.renameProperty(onType: BookTable.className(), from: "like", to: "heart")
            }
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

