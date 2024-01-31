//
//  ViewController.swift
//  TestCoreData
//
//  Created by yusef naser on 30/01/2024.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var dataController = DataController.shared
    
    var fetchedResultsController : NSFetchedResultsController<Movie>!
    
    private let tableView : UITableView = {
        let l = UITableView()
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.register(CellMovie.self , forCellReuseIdentifier: CellMovie.getIdentifier() )
        tableView.delegate = self
        tableView.dataSource = self
        
        setupFetchedResultController()
        
        addNote()
//        addNote()
//        addNote()
//        addNote()
//        addNote()
//        addNote()
//        addNote()
//        addNote()
//        addNote()
        
    }

    func setupFetchedResultController () {
          let fetchRequest : NSFetchRequest<Movie> = Movie.fetchRequest()
          let sort: NSSortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false )
          fetchRequest.sortDescriptors = [sort]
          
          fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest , managedObjectContext: dataController.viewContext , sectionNameKeyPath: nil , cacheName: nil )
          fetchedResultsController.delegate = self
          do{
              try fetchedResultsController.performFetch()
          }catch{
              fatalError("fatal error : \(error.localizedDescription)")
          }
      }
    
    
    // Adds a new `Note` to the end of the `notebook`'s `notes` array
       func addNote() {
        //   notebook.addNote()
           let newNote = Movie(context: dataController.viewContext)
           newNote.title = "namesdasd"
           newNote.creationDate = Date()
           newNote.id = 34
           newNote.overview = "asdas"
           newNote.releaseDate = "asd fdja fae f"
           try? dataController.viewContext.save()

       }

       // Deletes the `Note` at the specified index path
       func deleteNote(at indexPath: IndexPath) {
      //     notebook.removeNote(at: indexPath.row)
           let noteToDelete = fetchedResultsController.object(at: indexPath)
           dataController.viewContext.delete(noteToDelete)
           try? dataController.viewContext.save()
          
       }
    
}

extension ViewController : UITableViewDelegate  , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return fetchedResultsController.sections?.count ?? 1
        }

    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fetchedResultsController.sections?[section].numberOfObjects ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let aNote = fetchedResultsController.object(at: indexPath)
            let cell = tableView.dequeueReusableCell(withIdentifier: CellMovie.getIdentifier() , for: indexPath) as! CellMovie
            
            cell.setData(urlString: "", name: aNote.title , releaseDate: aNote.releaseDate , isFavorite: false )
            // Configure cell
//            cell.textPreviewLabel.attributedText = aNote.attributedText
//            if let creationDate = aNote.creationDate {
//                cell.dateLabel.text = dateFormatter.string(from: creationDate)
//            }
            

            return cell
        }

        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            switch editingStyle {
            case .delete: deleteNote(at: indexPath)
            default: () // Unsupported
            }
        }
    
}

extension ViewController : NSFetchedResultsControllerDelegate {
    
    
       func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.beginUpdates()
       }
       
       func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
           tableView.endUpdates()
       }
       
       func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
           
           let indexSet = IndexSet(integer: sectionIndex)
           switch type {
           case .insert: tableView.insertSections(indexSet, with: .fade)
           case .delete: tableView.deleteSections(indexSet, with: .fade)
           case .update, .move:
               fatalError("Invalid change type in controller(_:didChange:atSectionIndex:for:). Only .insert or .delete should be possible.")
           }
       }
       
       func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
           switch type {
           case .insert:
               tableView.insertRows(at: [newIndexPath!], with: .fade)
               break
           case .delete:
               tableView.deleteRows(at: [indexPath!], with: .fade)
               break
           case .update:
               tableView.reloadRows(at: [indexPath!], with: .fade)
           case .move:
               tableView.moveRow(at: indexPath!, to: newIndexPath!)
           }
       }
    
}

