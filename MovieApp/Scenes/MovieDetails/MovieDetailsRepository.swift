//
//  MovieDetailsRepository.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class MovieDetailsRepository {
    
    func getMovieDetails (movieID : Int , completionSuccess : @escaping CompletionSuccess<EntityMovies> , completionError : @escaping CompletionError ) {
        
        let request = RequestMovieDetails()
        request.addPath(movieID: movieID)
        APIClient<EntityMovies>.performRequest(request: request) { result  in
            switch result {
            case .success(let data) :
                completionSuccess(data)
                break
            case .failure(let error ):
                completionError(error)
                break
            }
        }
        
    }
    
}
