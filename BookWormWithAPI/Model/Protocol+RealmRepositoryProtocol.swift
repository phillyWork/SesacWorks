//
//  RealmRepositoryProtocol.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/09/06.
//

import Foundation
import RealmSwift

protocol RealmRepositoryProtocol: AnyObject {

    func checkSchemaVersion()
    func createItem<T: Object>(task: T)
    func fetch<T: Object>() -> Results<T>
    func updateItem(task: [String: Any], type: RealmUpdate)
    func deleteItem<T: Object>(task: T)
}
