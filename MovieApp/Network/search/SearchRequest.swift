//
//  SearchRequest.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import Foundation

struct SearchRequest : RequestModel {
    
    var path: String = "search/movie"
    
    var queries: [URLQueryItem] = []
    
    var httpMethod: HTTPMethod = .get
    
    mutating func appendQueries (name : String) {
        let q =  [
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "language", value: "en-US"),

        ]
        queries.append(URLQueryItem(name: "query", value: name))
        queries.append(contentsOf: q)
    }
    
    mutating func setPage (page : Int) {
        queries.append(URLQueryItem(name: "page", value: "\(page)"))
    }
    
}
