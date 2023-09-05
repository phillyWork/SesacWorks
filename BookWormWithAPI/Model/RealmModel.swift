//
//  RealmModel.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/09/04.
//

import Foundation
import RealmSwift

class BookTable: Object {
    
    @Persisted(primaryKey: true)var _id: ObjectId
    @Persisted var title: String
    @Persisted var author: String
    @Persisted var contents: String?
    @Persisted var date: String?
    @Persisted var isbn: String
    @Persisted var thumbnailURL: String?
    @Persisted var price: Int
    @Persisted var like: Bool
    @Persisted var memo: String?
    
    convenience init(title: String, author: String, contents: String?, date: String?, isbn: String, thumbnailURL: String?, price: Int, like: Bool, memo: String?) {
        self.init()
        self.title = title
        self.author = author
        self.contents = contents
        self.date = date
        self.isbn = isbn
        self.thumbnailURL = thumbnailURL
        self.price = price
        self.like = like
        self.memo = memo
    }
    
}
