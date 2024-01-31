//
//  Router.swift
//  MovieApp
//
//  Created by yusef naser on 31/01/2024.
//

class Router {
    
    static func createHomeVC () -> HomeVC {
        let repo = HomeRepository()
        let useCase = HomeUseCase(repo: repo)
        let viewModel = HomeViewModel(useCase: useCase)
        let vc = HomeVC()
        vc.viewModel = viewModel
        return vc
        
    }
    
    static func createMovieDetailsVC (movieID : Int?) -> MovieDetailsVC{
        let repo = MovieDetailsRepository()
        let useCase = MovieDetailsUseCase(repo: repo)
        let viewModel = MovieDetailsViewModel(useCase: useCase)
        viewModel.movieID = movieID
        let vc = MovieDetailsVC()
        vc.viewModel = viewModel
        return vc
    }
    
    static func createSearchVC () -> SearchVC {
        let repo = SearchRepository()
        let useCase = SearchUseCase(repo: repo)
        let viewModel = SearchViewModel(useCase: useCase)
        let vc = SearchVC()
        vc.viewModel = viewModel
        return vc
    }
    static func createFavoriteVC () -> FavoriteVC{
        let viewModel = FavoriteViewModel()
        let vc = FavoriteVC()
        vc.viewModel = viewModel
        return vc
    }
    
}
