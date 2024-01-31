//
//  SearchRepository.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

 
class SearchRepository {
    
    func searchMovie (text : String , page : Int , completionSuccess : @escaping CompletionSuccess<EntityDiscoverMovies> , completionError : @escaping CompletionError ) {
        var request = SearchRequest()
        request.appendQueries(name: text)
        request.setPage(page: page)
        
        APIClient <EntityDiscoverMovies>.performRequest(request: request) { result in
            
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
