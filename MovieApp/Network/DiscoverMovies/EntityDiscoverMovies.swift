//
//  EntityDiscoverMovies.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

struct EntityDiscoverMovies : Codable {
    let page: Int?
    let results: [EntityMovies]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

}
