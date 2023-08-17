//
//  SeasonDetail.swift
//  TMDBAPICallTwiceInARow
//
//  Created by Heedon on 2023/08/16.
//

import Foundation

// MARK: - SeasonDetail
struct SeasonDetail: Codable {
    let id, airDate: String
    let episodes: [Episode]
    let name, overview: String
    let seasonDetailID: Int
    let posterPath: String
    let seasonNumber: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case seasonDetailID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}

// MARK: - Episode
struct Episode: Codable {
    let airDate: String
    let episodeNumber: Int
    let episodeType: EpisodeType
    let id: Int
    let name, overview, productionCode: String
    let runtime: Int?
    let seasonNumber, showID: Int
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int
    let crew, guestStars: [Crew]

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id, name, overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
        case guestStars = "guest_stars"
    }
    
    var seasonEpisodeNumber: String {
        return "S\(seasonNumber) ● E\(episodeNumber)"
    }
}

// MARK: - Crew
struct Crew: Codable {
    let job: Job?
    let department: Department?
    let creditID: String
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: Department
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let character: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case job, department
        case creditID = "credit_id"
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case character, order
    }
}

enum Department: String, Codable {
    case acting = "Acting"
    case art = "Art"
    case directing = "Directing"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}

enum Job: String, Codable {
    case animationDirector = "Animation Director"
    case artDirection = "Art Direction"
    case assistantDirector = "Assistant Director"
    case director = "Director"
    case keyAnimation = "Key Animation"
    case openingEndingAnimation = "Opening/Ending Animation"
    case screenplay = "Screenplay"
    case storyboardArtist = "Storyboard Artist"
    case supervisingAnimationDirector = "Supervising Animation Director"
    case writer = "Writer"
}

enum EpisodeType: String, Codable {
    case standard = "standard"
}
