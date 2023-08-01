//
//  DataManager.swift
//  BookWorm
//
//  Created by Heedon on 2023/08/01.
//

import UIKit

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    private var bookData = BookInfo().books
    
    func getTotalBooks() -> [Book] {
        return bookData
    }
    
    func updateBookLike(updatedBook: Book) {
        //동일 이름 없다는 전제
        //차후: 책의 ISBN number와 같은 것으로 구분 가능
        if let index = bookData.firstIndex(where: { $0.title == updatedBook.title }) {
            bookData[index].like.toggle()
        }
    }
    
}
