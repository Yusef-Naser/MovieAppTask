//
//  EntityMovie.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

struct EntityMovies : Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    private let posterPath : String?
    var getPosterPath : String? {
        if let path = posterPath , path.count > 0 {
            return "https://image.tmdb.org/t/p/w500\(posterPath ?? "")"
        }
        return nil
    }
    
    var isFavorite : Bool?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case isFavorite
    }
    
    init( id: Int?, originalTitle: String?, overview: String?, releaseDate: String?, title: String?, posterPath: String?, isFavorite: Bool? = nil) {
        
        self.adult = nil
        self.backdropPath = nil
        self.genreIDS = nil
        self.id = id
        self.originalLanguage = nil
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = nil
        self.releaseDate = releaseDate
        self.title = title
        self.video = nil
        self.voteAverage = nil
        self.voteCount = nil
        self.posterPath = posterPath
        self.isFavorite = isFavorite
        
    }
}
