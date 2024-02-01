//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation
import UIKit
import CoreData

class HomeViewModel : BaseViewModel {
    
    var dataController  = DataController.shared
    var fetchedResultsController : NSFetchedResultsController<Movie>?
    
    // handle pagination
    var pageResults = PaginationClass<EntityMovies>()
    
    // use this variable to detect if user swipe to refresh or not
    private var refresh = false
    
    var sort : SortMovies = .popularity_desc
    
    var fetchData : (([EntityMovies])->Void)? = nil
        
    var useCase : HomeUseCase?
    
    init (useCase : HomeUseCase) {
        super.init()
        self.useCase = useCase
    }
  
    private func setupFetchedResultController (id : Int) {
        fetchedResultsController = nil
        let fetchRequest : NSFetchRequest<Movie> = Movie.fetchRequest()
        let predicate = NSPredicate(format: "id == %i", Int64(id))
        fetchRequest.predicate = predicate
        let sort: NSSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false )
        fetchRequest.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: dataController.viewContext , sectionNameKeyPath: nil , cacheName: nil )
        
        do{
            try fetchedResultsController?.performFetch()
        }catch{
            fatalError("fatal error : \(error.localizedDescription)")
        }
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
        cell.setData(urlString: item.getPosterPath , name: item.title , releaseDate: item.releaseDate, isFavorite: item.isFavorite)
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
    
    func addOrDeleteMovie (entityMovie : EntityMovies, image : UIImage? , indexPath : IndexPath ) {
        setupFetchedResultController(id: entityMovie.id ?? 0)
        if ((fetchedResultsController?.sections?[0].numberOfObjects ?? 0) > 0) {
            deleteMovie(at: indexPath)
            updateItemFavorite(indexPath: indexPath, isFavorite: false)
        }else {
            addMovie(entityMovie: entityMovie , image: image)
            updateItemFavorite(indexPath: indexPath, isFavorite: true)
        }
            
    }
    
    private func addMovie(entityMovie : EntityMovies, image : UIImage? ) {
            let movie = Movie(context: dataController.viewContext)
            movie.id = Int64(entityMovie.id ?? 0)
            movie.creationDate = Date()
            movie.title = entityMovie.title ?? ""
            movie.releaseDate = entityMovie.releaseDate ?? ""
            movie.poster = image?.jpegData(compressionQuality: 0.5)
            do {
                try dataController.viewContext.save()
           //     listIDs.append(entityMovie.id ?? 0)
            }catch {
                showError?(error.localizedDescription)
            }
    }
    
    private func deleteMovie(at indexPath: IndexPath) {
        guard let item = getItem(index: indexPath) else {
            return
        }
        setupFetchedResultController(id: item.id ?? 0)
        if fetchedResultsController?.sections?.count ?? 0 > 0 , fetchedResultsController?.sections?[0].numberOfObjects ?? 0 > 0 {
            guard let movieDeleted = fetchedResultsController?.object(at: IndexPath(row: 0, section: 0)) else {
                return
            }
            dataController.viewContext.delete(movieDeleted)
            try? dataController.viewContext.save()
//            listIDs.removeAll { itemID in
//                item.id == itemID
//            }
        }
    }
    
}
