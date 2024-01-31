//
//  HomeUseCase.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class HomeUseCase {
    
    var repo : HomeRepository
    
    init(repo : HomeRepository) {
        self.repo = repo
    }
    
    func getTrendingMovies (sort : SortMovies , page : Int , completionSuccess : @escaping CompletionSuccess<EntityDiscoverMovies> , completionError : @escaping CompletionError ) {
        
        repo.getTrendingMovies(sort: sort , page: page) { data  in
            completionSuccess(data)
        } completionError: { error  in
            completionError(error)
        }

    }
    
}
