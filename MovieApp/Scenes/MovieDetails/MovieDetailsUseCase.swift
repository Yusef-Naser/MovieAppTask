//
//  MovieDetailsUseCase.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class MovieDetailsUseCase {
    
    var repo : MovieDetailsRepository?
    
    init(repo: MovieDetailsRepository? = nil) {
        self.repo = repo
    }
    
    func getMovieDetails (movieID : Int , completionSuccess : @escaping CompletionSuccess<EntityMovies> , completionError : @escaping CompletionError) {
        repo?.getMovieDetails(movieID: movieID , completionSuccess: { data  in
            completionSuccess(data)
        }, completionError: { error  in
            completionError(error)
        })
    }
    
}
