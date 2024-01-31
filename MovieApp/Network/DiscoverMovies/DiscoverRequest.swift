//
//  DiscoverRequest.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

struct DiscoverRequest : RequestModel {
    
    var path: String = "discover/movie"
    
    var queries: [URLQueryItem] = [
        URLQueryItem(name: "include_adult", value: "false"),
        URLQueryItem(name: "language", value: "en-US"),
    ]
    
    var httpMethod: HTTPMethod
    
    
    mutating func setSort (sort : SortMovies) {
        queries.removeAll { item in
            item.name == "sort_by"
        }
        queries.append(URLQueryItem(name: "sort_by" , value: sort.rawValue ))
    }
    
    mutating func setPage (page : Int) {
        queries.removeAll { item in
            item.name == "page"
        }
        queries.append(URLQueryItem(name: "page", value: "\(page)"))
        
    }
    
}
