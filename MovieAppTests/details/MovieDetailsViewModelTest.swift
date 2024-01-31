//
//  MovieDetailsViewModelTest.swift
//  MovieAppTests
//
//  Created by yusef naser on 31/01/2024.
//

import Foundation

@testable import MovieApp
import XCTest


class MovieDetailsViewModelTest : XCTestCase {
    
    var viewModel : MovieDetailsViewModel?
    
    
    override func setUp() {
        super.setUp()
        viewModel = MovieDetailsViewModel(useCase: MovieDetailsUseCaseTest(repo: MovieDetailsRepository()))
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
  
    func testGetMovie () {
        viewModel?.fetchData = { movie in
            XCTAssertEqual(movie.id , StaticData.movie_1.id)
        }
        viewModel?.getMovieDetails()
        
    }
    
}

class MovieDetailsUseCaseTest : MovieDetailsUseCase {
    
    override func getMovieDetails(movieID: Int, completionSuccess: @escaping CompletionSuccess<EntityMovies>, completionError: @escaping CompletionError) {
        
        completionSuccess(StaticData.movie_1)
        
    }
    
}

