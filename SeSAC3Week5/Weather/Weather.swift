//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by Heedon on 2023/08/17.
//

import Foundation

// MARK: - Weather
struct WeatherData: Codable {
    let sys: Sys
    let dt, timezone, cod: Int
    let weather: [WeatherElement]
    let visibility: Int
    let wind: Wind
    let coord: Coord
    let main: Main
    let name, base: String
    let clouds: Clouds
    let id: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Codable {
    let feelsLike: Double
    let grndLevel: Int
    let tempMin: Double
    let pressure: Int
    let tempMax: Double
    let seaLevel, humidity: Int
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case feelsLike = "feels_like"
        case grndLevel = "grnd_level"
        case tempMin = "temp_min"
        case pressure
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case humidity, temp
    }
}

// MARK: - Sys
struct Sys: Codable {
    let country: String
    let sunrise, type, sunset, id: Int
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let main, icon, description: String
    let id: Int
}

// MARK: - Wind
struct Wind: Codable {
    let deg: Int
    let speed, gust: Double
}
