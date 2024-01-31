//
//  RequestModel.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import Foundation

enum HTTPMethod : String {
    case post
    case get
}

protocol RequestModel {
    
    var path : String { get }
    var queries : [URLQueryItem] {get}
    var httpMethod : HTTPMethod {get}
    
    
}

extension RequestModel {
    
    var headers : [String: String]  {
        [
          "accept": "application/json",
          "Authorization": "Bearer \(Constants.API_KEY)"
        ]
    }
    func buildRequest() -> URLRequest {
        
        let queryItems = queries
        var urlComps = URLComponents(string: Constants.URL + self.path)!
        urlComps.queryItems = queryItems
        var urlRequest = URLRequest(url: urlComps.url! )
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = self.httpMethod.rawValue
        return urlRequest
    }
}
