//
//  MovieDetailsVC.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import UIKit

class MovieDetailsVC : BaseVC<MovieDetailsView > {
    
    
    var viewModel : MovieDetailsViewModel?
    var movieID : Int?
    
    init(movieID: Int) {
        self.movieID = movieID
        viewModel = MovieDetailsViewModel(useCase: MovieDetailsUseCase(repo: MovieDetailsRepository() ))
        viewModel?.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil , bundle: nibBundleOrNil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callBacksViewModel()
        viewModel?.getMovieDetails()
        
    }
    
}

extension MovieDetailsVC {
    
    func callBacksViewModel () {
        viewModel?.showLoading = { b in
            if (b) {
                self.showLoading()
            }else {
                self.hideLoading()
            }
        }
        
        viewModel?.showError = { error in
            self.onError(error)
        }
        viewModel?.fetchData = { data in
            self.mainView.setData(poster: data.getPosterPath , title: data.title, releaseData: data.releaseDate, overView: data.overview)
        }
    }
    
}
