//
//  DataManager.swift
//  BookWormWithAPI
//
//  Created by Heedon on 2023/08/08.
//

import Foundation
import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    private init() { }
    
    private var books : [Book] = []
    private var likedBooks: [Book] = []
    private var searchBooks: [Book] = []
    
    private var realmHistoryBooks: Results<BookTable>!

    //page: 1~50 사이의 값, 기본 값 1
    //size: 1~50 사이의 값, 기본 값 10
    //isEnd: 마지막 페이지인지 확인
    private var page = 1
    private let size = 15
    private var isEnd = false
    
    //MARK: - GET
    
    func getPageNum() -> Int {
        return page
    }
    
    func getSize() -> Int {
        return size
    }
    
    func getCurrentIsEnd() -> Bool {
        return isEnd
    }
    
    func getBooks() -> [Book] {
        return books
    }
    
    func getLikedBooks() -> [Book] {
        return likedBooks
    }
    
    func getSearchBooks() -> [Book] {
        return searchBooks
    }
    
    func getRealmHistoryBooks() -> Results<BookTable> {
        return realmHistoryBooks
    }
    
    //MARK: - UPDATE
    
    func addPageNumber() {
        page += 1
    }
    
    func addSearchBook(book: Book) {
        searchBooks.append(book)
    }
    
    func addRealmHistoryBooks(tasks: Results<BookTable>) {
        self.realmHistoryBooks = tasks
    }
    
    func addLikeFromSearch(book: Book, searchTag: Int) {
        for (index, item) in searchBooks.enumerated() {
            if item.isbn == book.isbn {
                searchBooks[index].like.toggle()
                likedBooks.append(item)
                likedBooks[likedBooks.count - 1].like.toggle()
            }
        }
    }
    
    func removeLikeFromSearch(book: Book, searchTag: Int) {
        for (index, item) in searchBooks.enumerated() {
            if item.isbn == book.isbn {
                searchBooks[index].like.toggle()
                
                for (likeIndex, likedBook) in likedBooks.enumerated() {
                    if likedBook.isbn == book.isbn {
                        likedBooks.remove(at: likeIndex)
                    }
                }
            }
        }
    }
    
    func removeLikeFromLike(book: Book, likeTag: Int) {
        for (index, item) in likedBooks.enumerated() {
            if item.isbn == book.isbn {
                likedBooks.remove(at: index)
            }
            
            for (searchIndex, searchBook) in searchBooks.enumerated() {
                if searchBook.isbn == book.isbn {
                    searchBooks[searchIndex].like.toggle()
                }
            }
        }
    }
    
    func updateIsEnd(value: Bool) {
        isEnd = value
    }
    
    func removeSearchList() {
        searchBooks.removeAll()
    }
    
    func resetPageNum() {
        page = 1
    }
    
    
}
