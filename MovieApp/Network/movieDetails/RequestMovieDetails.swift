//
//  RequestMovieDetails.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class RequestMovieDetails : RequestModel {
    var path: String = "movie/"
    
    var queries: [URLQueryItem] = [
        URLQueryItem(name: "language", value: "en-US")
    ]
    
    var httpMethod: HTTPMethod = .get
    
    func addPath (movieID : Int ) {
        path = path + "\(movieID)"
    }
    
    
    
}
