//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class SearchViewModel : BaseViewModel {
    
    // handle pagination
    var pageResults = PaginationClass<EntityMovies>()
    
    var fetchData : (([EntityMovies])->Void)? = nil
    var useCase : SearchUseCase?
    // use this variable to detect if user swipe to refresh or not
    private var refresh = false
    private var searchText = ""
    
    init(useCase : SearchUseCase) {
        self.useCase = useCase
    }
    func searchMovies (text : String) {
        self.searchText = text
        if !(pageResults.beforeCallService()){
            return
        }
                      
        if refresh{
            refresh = false
        }else {
            self.showLoading?(true )
        }
        
        useCase?.searchMovie(text: text , page: pageResults.currentPage, completionSuccess: { [weak self] data in
            
            self?.showLoading?(false)
            self?.pageResults.setDataPagination(listData: data.results ?? [] , currentPage: data.page ?? 1, totalPages: data.totalPages ?? 1)
            
            DispatchQueue.main.async {
                self?.fetchData?(self?.pageResults.listData ?? [])
            }
            
        }, completionError: { error  in
            self.showError?(error.localizedDescription)
        })
    }
    
    func getMoviesCount() -> Int {
        return pageResults.listData.count
    }
    
    // send  data to cell by conform "ConfigurationCell" to cell
    func configurationMovies(cell : ConfigurationCellMovie , index : Int ) {
        if index >= pageResults.listData.count {
            return
        }
        let item = pageResults.listData[index]
        cell.setData(urlString: item.getPosterPath , name: item.title , releaseDate: item.releaseDate, isFavorite: false)
    }
    
    // when user swip to refresh and reset data
    func refreshData() {
        pageResults.resetData()
        refresh = true
        searchMovies(text: searchText)
    }
    
    // call this function in WillDisplay in collectionView
    func callPaginate(index : Int ) {
        if pageResults.allowPagination(index: index) {
            searchMovies(text: searchText)
        }
    }
    
    func getItem (index : IndexPath) -> EntityMovies? {
        guard index.row < pageResults.listData.count else {
            return nil
        }
        let item = pageResults.listData[index.row]
        return item
    }
}
