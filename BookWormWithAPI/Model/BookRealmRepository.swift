//
//  RealmManager.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/09/06.
//

import Foundation
import RealmSwift

class BookRealmRepository: RealmRepositoryProtocol {
   
    let realm = try! Realm()

    //MARK: - Schema
    
    private func getRealmFilePath() -> URL? {
        guard let filePath = realm.configuration.fileURL else { return nil }
        return filePath
    }

    func checkSchemaVersion() {
        do {
            if let filePath = getRealmFilePath() {
                let version = try schemaVersionAtURL(filePath)
                print("Schema Version: \(version)")
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - CREATE
    
    func createItem<T:Object>(task: T) {
        do {
            try realm.write {
                realm.add(task)
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - READ
    func fetch<T: Object>() -> Results<T> {
        let objects = realm.objects(T.self)
        return objects
    }
    
    func fetchSort(keyPath: String, isAscending: Bool) -> Results<BookTable> {
        let sorted = (fetch() as Results<BookTable>).sorted(byKeyPath: keyPath, ascending: isAscending)
        return sorted
    }
    
    func fetchSortFilter(keyPath: String, isAscending: Bool) -> Results<BookTable> {
        let filtered = fetchSort(keyPath: keyPath, isAscending: isAscending).where { $0.price > 5000 }
        return filtered
    }

    //MARK: - UPDATE
    func updateItem(task: [String: Any], type: RealmUpdate) {
        do {
            try realm.write {
                switch type {
                case .upsert:
                    let newData = BookTable(value: task)
                    realm.add(newData, update: .modified)
                case .partial:
                    realm.create(BookTable.self, value: task, update: .modified)
                }
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - DELETE
    func deleteItem<T: Object>(task: T) {
        do {
            try realm.write {
                realm.delete(task)
            }
        } catch {
            print(error)
        }
    }
    
}
