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
    private var recentlySeenBooks = [Book]()    //5개 제한
    
    private let recentMax = 5
    
    //검색 결과
    private var searchResults = [Book]()
    
    
    //MARK: - GET
    
    func getTotalBooks() -> [Book] {
        return bookData
    }
    
    func getRecentlySeenBooks() -> [Book] {
        return recentlySeenBooks
    }
    
    func getSearchResults() -> [Book] {
        return searchResults
    }
    
    //MARK: - SET
    
    func updateBookLike(updatedBook: Book, tag: Int, dataType: DataType) {
        //동일 이름 없다는 전제
        //차후: 책의 ISBN number와 같은 것으로 구분 가능
        
        for (index, item) in bookData.enumerated() {    //index로 item 찾기
            if item.title == updatedBook.title {
                bookData[index].like.toggle()
            }
        }

        //search 결과인 경우에만 search도 toggle
        if dataType == .search {
            searchResults[tag].like.toggle()
        }
        
    }
    
    func addRecentlySeenBook(newBook: Book?) {
    
        guard let book = newBook else {
            print("No Book to update Recent History")
            return
        }
        
        //이미 존재하는 경우, 해당 index의 element 제거
        for (index, data) in recentlySeenBooks.enumerated() {
            if data.title == newBook?.title {
                recentlySeenBooks.remove(at: index)
            }
        }
        
        //가득 찬 경우: 가장 마지막 index element 제거
        if recentlySeenBooks.count == recentMax {
            recentlySeenBooks.remove(at: recentMax-1)
        }
        
        
        
//        if recentlySeenBooks.contains(book) {
//            let index = recentlySeenBooks.firstIndex(of: book)!
//            print("index: \(index)")
//            recentlySeenBooks.remove(at: index)
//        } else {
//            if recentlySeenBooks.count == recentMax {
//                //가장 안본 것 목록에서 제거
//                recentlySeenBooks.remove(at: recentMax - 1)
//            }
//        }
        
        //최근 것을 가장 앞에서 추가
        recentlySeenBooks.insert(book, at: 0)
    }
    
    func updateSearchResults(searchResult: [Book]?) {
        
        if let searchResult = searchResult {
            searchResults = searchResult
        } else {
            //검색 결과 없음: 빈 배열
            searchResults = []
        }
    }
    
}
