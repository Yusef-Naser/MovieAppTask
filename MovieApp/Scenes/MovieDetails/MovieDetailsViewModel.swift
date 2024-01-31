//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class MovieDetailsViewModel : BaseViewModel {
    
    var movieID : Int?
    var movie : EntityMovies?
    
    var fetchData : ((EntityMovies)->Void)? = nil
    var useCase : MovieDetailsUseCase?
    init(useCase: MovieDetailsUseCase) {
        super.init()
        self.useCase = useCase
    }
    
    func getMovieDetails () {
        self.showLoading?(true)
        useCase?.getMovieDetails(movieID: movieID ?? 0 , completionSuccess: { data  in
            self.showLoading?(false)
            self.movie = data
            self.fetchData?(data)
        }, completionError: { error  in
            self.showLoading?(false)
            self.showError?(error.localizedDescription)
        })
    }
}
