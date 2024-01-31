//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class HomeViewModel : BaseViewModel {
    
    
    // handle pagination
    var pageResults = PaginationClass<EntityMovies>()
    
    // use this variable to detect if user swipe to refresh or not
    private var refresh = false
    
    var sort : SortMovies = .popularity_asc
    
    var fetchData : (([EntityMovies])->Void)? = nil
        
    var useCase : HomeUseCase?
    
    init (useCase : HomeUseCase) {
        self.useCase = useCase
    }
  
    
    func getDiscoverMovies() {
        
        if !(pageResults.beforeCallService()){
            return
        }
                      
        if refresh{
            refresh = false
        }else {
            self.showLoading?(true )
        }
        
        useCase?.getTrendingMovies(sort: sort, page: pageResults.currentPage, completionSuccess: { [weak self] data  in
            
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
        cell.setData(urlString: item.getPosterPath , name: item.title , releaseDate: item.releaseDate, isFavorite: listIDs.filter({ id in
                item.id == id
        }).first != nil
        )
    }
    
    // when user swip to refresh and reset data
    func refreshData() {
        pageResults.resetData()
        refresh = true
        getDiscoverMovies()
    }
    
    // call this function in WillDisplay in collectionView
    func callPaginate(index : Int ) {
        if pageResults.allowPagination(index: index) {
            getDiscoverMovies()
        }
    }
    
    func getItem (index : IndexPath) -> EntityMovies? {
        guard index.row < pageResults.listData.count else {
            return nil
        }
        let item = pageResults.listData[index.row]
        return item
    }
    
    func updateItemFavorite (indexPath : IndexPath , isFavorite : Bool ) {
        guard var item = getItem(index: indexPath) else {
            return
        }
        item.isFavorite = isFavorite
        pageResults.listData.remove(at: indexPath.row)
        pageResults.listData.insert(item, at: indexPath.row)
    }
    
}
