//
//  EntitySearch.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//


struct EntitySearch : Codable {
    let page: Int?
    let results: [EntityMovies]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

