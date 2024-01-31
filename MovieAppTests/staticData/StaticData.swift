//
//  StaticData.swift
//  MovieAppTests
//
//  Created by yusef naser on 31/01/2024.
//

@testable import MovieApp

class StaticData {
    
    static let movie_1 = EntityMovies(id: 11, originalTitle: "originalTitle_1", overview: "overview_1", releaseDate: "releaseDate_1", title: "title_1", posterPath: "posterPath_1", isFavorite: false)
    
    static let movie_2 = EntityMovies(id: 22, originalTitle: "originalTitle_2", overview: "overview_2", releaseDate: "releaseDate_2", title: "title_2", posterPath: "posterPath_2", isFavorite: false)
    
    static let movie_3 = EntityMovies(id: 33, originalTitle: "originalTitle_3", overview: "overview_3", releaseDate: "releaseDate_3", title: "title_3", posterPath: "posterPath_3", isFavorite: true)
    
    static let movie_4 = EntityMovies(id: 44, originalTitle: "originalTitle_4", overview: "overview_4", releaseDate: "releaseDate_4", title: "title_4", posterPath: "posterPath_4", isFavorite: true)
    
    
    static let listMovies = [movie_1 , movie_2 , movie_3 , movie_4]
    
    
    
}
