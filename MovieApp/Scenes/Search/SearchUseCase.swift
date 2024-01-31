//
//  SearchUseCase.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class SearchUseCase {
    
    private var repo : SearchRepository?
    
    init(repo: SearchRepository? = nil) {
        self.repo = repo
    }
    
    func searchMovie(text : String , page : Int , completionSuccess : @escaping CompletionSuccess<EntityDiscoverMovies> , completionError : @escaping CompletionError){
        
        repo?.searchMovie(text: text , page: page , completionSuccess: { data  in
            completionSuccess(data)
        }, completionError: { error  in
            completionError(error)
        })
        
    }
    
}
