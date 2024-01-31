//
//  HomeViewModelTests.swift
//  MovieAppTests
//
//  Created by yusef naser on 31/01/2024.
//

import XCTest
@testable import MovieApp

class HomeViewModelTests : XCTestCase {
    
    var viewModel : HomeViewModel?
    
    static var sortGlobal : SortMovies?
    
    override func setUp() {
        super.setUp()
        
       viewModel = HomeViewModel(useCase: HomeUseCaseTests(repo: HomeRepository()))
                
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    
    func testSetSort() {
        let sort = SortMovies.primary_release_date_desc
        viewModel?.sort = sort
        viewModel?.getDiscoverMovies()
        HomeViewModelTests.sortGlobal = sort
        
        XCTAssertEqual(HomeViewModelTests.sortGlobal, sort)
        
    }
    
    func testCallApi() {
        
        viewModel?.getDiscoverMovies()
        viewModel?.fetchData = { movies in
            XCTAssertEqual(StaticData.listMovies.count, movies.count)
        }
    }
    
    func testItemsCount () {
        viewModel?.getDiscoverMovies()
        XCTAssertEqual(StaticData.listMovies.count, viewModel?.pageResults.listData.count)
    }
    
    func testGetItem () {
        viewModel?.getDiscoverMovies()
        let item = viewModel?.getItem(index: IndexPath(row: 0, section: 0))
        XCTAssertEqual(StaticData.listMovies[0].id, item?.id )
    }
    
}

class HomeUseCaseTests : HomeUseCase {
    
    override func getTrendingMovies(sort: SortMovies, page: Int, completionSuccess: @escaping CompletionSuccess<EntityDiscoverMovies>, completionError: @escaping CompletionError) {
        
        HomeViewModelTests.sortGlobal = sort
        let movies = EntityDiscoverMovies(page: 1, results: StaticData.listMovies , totalPages: 100, totalResults: 200)
        completionSuccess(movies)
        
    }
    
}
