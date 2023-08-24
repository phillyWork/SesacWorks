//
//  DataManager.swift
//  CoreLocationMapKitTheater
//
//  Created by Heedon on 2023/08/23.
//

import Foundation
import CoreLocation

class DataManager {
    
    static let shared = DataManager()
    private init() { }
    
    private let theaterList = TheaterList().mapAnnotations
    
    //기본 위치: sesac 영등포 캠퍼스
    private let defaultCenter = CLLocationCoordinate2D(latitude: 37.517753, longitude: 126.886228)
    
    private var currentUserLocation: CLLocationCoordinate2D?
    
    //MARK: - GET
    
    func getCurrentLocation() -> CLLocationCoordinate2D {
        if let currentLocation = currentUserLocation {
            print("It's getting current Location: \(currentLocation)")
            return currentLocation
        } else {
            print("It's getting Sesac office: \(defaultCenter)")
            return defaultCenter
        }
    }
    
    func getWholeList() -> [Theater] {
        return theaterList
    }
    
    func getCGVList() -> [Theater] {
        return theaterList.filter { $0.type == .CGV }
    }
    
    func getLotteList() -> [Theater] {
        return theaterList.filter { $0.type == .LotteCinema }
    }
    
    func getMegaList() -> [Theater] {
        return theaterList.filter { $0.type == .MegaBox }
    }
    
    //MARK: - UPDATE
    
    func updateCurrentUser(currentLocation: CLLocationCoordinate2D) {
        currentUserLocation = currentLocation
    }
    
    
    
}
