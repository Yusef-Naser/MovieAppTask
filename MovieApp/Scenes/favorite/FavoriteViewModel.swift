//
//  FavoriteViewModel.swift
//  MovieApp
//
//  Created by yusef naser on 30/01/2024.
//

import Foundation
import CoreData

class FavoriteViewModel : BaseViewModel {
    
    var dataController = DataController.shared
    var fetchedResultsController : NSFetchedResultsController<Movie>!
    
    override init () {
        super.init()
        setupFetchedResultController()
    }
    
    private func setupFetchedResultController () {
        let fetchRequest : NSFetchRequest<Movie> = Movie.fetchRequest()
        let sort: NSSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false )
        fetchRequest.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: dataController.viewContext , sectionNameKeyPath: nil , cacheName: nil )
        
        do{
            try fetchedResultsController.performFetch()
        }catch{
            fatalError("fatal error : \(error.localizedDescription)")
        }
      }
    
    func deleteMovie(at indexPath: IndexPath) {
        let movieDeleted = fetchedResultsController.object(at: indexPath)
        dataController.viewContext.delete(movieDeleted)
        try? dataController.viewContext.save()
       
    }
    
}
