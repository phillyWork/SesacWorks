//
//  TheaterList.swift
//  CoreLocationMapKitTheater
//
//  Created by Heedon on 2023/08/23.
//

import Foundation

struct TheaterList {
    var mapAnnotations: [Theater] = [
        Theater(type: .CGV, locationName: "CGV 신촌아트레온", latitude: 37.556575, longitude: 126.940292),
        Theater(type: .CGV, locationName: "CGV 용산 아이파크몰", latitude: 37.53149302830903, longitude: 126.9654030486416),
        Theater(type: .CGV, locationName: "CGV 연남", latitude: 37.557908, longitude: 126.925766),
        Theater(type: .CGV, locationName: "CGV 홍대", latitude: 37.556491, longitude: 126.922655),
        Theater(type: .CGV, locationName: "CGV 여의도", latitude: 37.525623, longitude: 126.925505),
        Theater(type: .CGV, locationName: "CGV 영등포", latitude: 37.52666023337906, longitude: 126.9258351013706),
        Theater(type: .LotteCinema, locationName: "롯데시네마 홍대입구", latitude: 37.557297, longitude: 126.925099),
        Theater(type: .LotteCinema, locationName: "롯데시네마 합정점", latitude: 37.551270, longitude: 126.913434),
        Theater(type: .LotteCinema, locationName: "롯데시네마 용산", latitude: 37.532800, longitude: 126.959707),
        Theater(type: .LotteCinema, locationName: "롯데시네마 서울대입구", latitude: 37.4824761978647, longitude: 126.9521680487202),
        Theater(type: .LotteCinema, locationName: "롯데시네마 가산디지털", latitude: 37.47947929602294, longitude: 126.88891083192269),
        Theater(type: .MegaBox, locationName: "메가박스 신촌", latitude: 37.559769, longitude:  126.941903),
        Theater(type: .MegaBox, locationName: "메가박스 홍대", latitude: 37.555991, longitude: 126.922044),
        Theater(type: .MegaBox, locationName: "메가박스 이수", latitude: 37.48581351541419, longitude:  126.98092132899579),
        Theater(type: .MegaBox, locationName: "메가박스 강남", latitude: 37.49948523972615, longitude: 127.02570417165666),
    ]
}
