//
//  HomeRepository.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class HomeRepository {
    
    func getTrendingMovies(sort : SortMovies , page : Int , completionSuccess : @escaping CompletionSuccess<EntityDiscoverMovies> , completionError : @escaping CompletionError
    ) {
        
        var request = DiscoverRequest( queries: [], httpMethod: .get)
        request.setSort(sort: sort)
        request.setPage(page: page)
        
        APIClient<EntityDiscoverMovies>.performRequest(request: request) { result  in
            switch result {
            case .success(let data) :
                completionSuccess(data)
                return
            case .failure(let error) :
                completionError(error)
                return
            }
        }
    }
    
}
