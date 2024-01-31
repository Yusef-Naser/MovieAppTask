//
//  FavoriteVC.swift
//  MovieApp
//
//  Created by yusef naser on 30/01/2024.
//

import Foundation
import UIKit
import CoreData

class FavoriteVC : BaseVC<FavoriteView> {
    
    var viewModel : FavoriteViewModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.setDelegate(vc:  self )
        viewModel?.fetchedResultsController.delegate = self
        
    }
    
    
    
}

extension FavoriteVC : UITableViewDelegate , UITableViewDataSource , CellMovieDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.fetchedResultsController.sections?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellMovie.getIdentifier() , for: indexPath) as! CellMovie
        
        guard let movie = viewModel?.fetchedResultsController.object(at: indexPath) else {
            return cell
        }
        
        cell.setData(image: movie.poster, name: movie.title, releaseDate: movie.releaseDate, isFavorite: true )
        cell.delegateCellMovie = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = viewModel?.fetchedResultsController.object(at: indexPath) else {
            return
        }
        self.navigationController?.pushViewController(MovieDetailsVC(movieID: Int(movie.id)) , animated: true )
    }
   
    func favoriteButton(cell: CellMovie) {
        guard let indexPath = mainView.tableView.indexPath(for: cell ) else {
            return
        }
        viewModel?.deleteMovie(at: indexPath)
        listIDs.remove(at: indexPath.row)
        self.mainView.tableView.reloadData()
    }
    
}

extension FavoriteVC : NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        mainView.tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        let indexSet = IndexSet(integer: sectionIndex)
        switch type {
        case .insert: mainView.tableView.insertSections(indexSet, with: .fade)
        case .delete: mainView.tableView.deleteSections(indexSet, with: .fade)
        case .update, .move:
            fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            mainView.tableView.insertRows(at: [newIndexPath!], with: .fade)
            break
        case .delete:
            mainView.tableView.deleteRows(at: [indexPath!], with: .fade)
            break
        case .update:
            mainView.tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            mainView.tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
}
