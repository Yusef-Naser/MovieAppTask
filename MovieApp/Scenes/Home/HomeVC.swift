//
//  HomeVC.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import Foundation
import UIKit

class HomeVC : BaseVC<HomeView> {
    
    var viewModel : HomeViewModel?
    var dataController  = DataController.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainView.setDelegate(vc: self)
        
        
        viewModel = HomeViewModel(useCase: HomeUseCase(repo: HomeRepository()))
        getCallBacksViewModel()
        viewModel?.getDiscoverMovies()
        
        // add refresh to collectionView
        refreshController = mainView.tableView.addRefreshController()
        refreshController?.addTarget(self , action: #selector(refreshMoveis), for: .valueChanged)
    }
    
    @objc private func refreshMoveis () {
        // refresh data and reset stored data in viewModel
        viewModel?.refreshData()
    }
    
    func setSort(sort : SortMovies){
        viewModel?.sort = sort
        showLoading()
        refreshMoveis()
    }
    
}


extension HomeVC  {
    func getCallBacksViewModel () {
        viewModel?.showLoading = { value in
            if value {
                self.showLoading()
            }else {
                self.hideLoading()
            }
        }
        viewModel?.showError = { error in
            self.onError(error)
        }
        
        viewModel?.fetchData = { data in
            self.mainView.tableView.reloadData()
            self.refreshController?.endRefreshing()
        }
    }
    
}
extension HomeVC : UITableViewDelegate , UITableViewDataSource , CellMovieDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel?.callPaginate(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getMoviesCount() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellMovie.getIdentifier() , for: indexPath) as! CellMovie
        
        viewModel?.configurationMovies(cell: cell , index: indexPath.row)
        cell.delegateCellMovie = self
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MovieDetailsVC(movieID: viewModel?.getItem(index: indexPath)?.id ?? 0) , animated: true )
    }
    
    
    func favoriteButton(cell: CellMovie) {
        guard let indexPath = self.mainView.tableView.indexPath(for: cell ) , let movie = viewModel?.getItem(index: indexPath) else {
            return
        }
        addMovie(entityMovie: movie , image: cell.imageMovies.image )
        viewModel?.updateItemFavorite(indexPath: indexPath , isFavorite: true )
        self.mainView.tableView.reloadData()
    }
    
    func addMovie(entityMovie : EntityMovies, image : UIImage?) {
        let movie = Movie(context: dataController.viewContext)
        movie.id = Int64(entityMovie.id ?? 0)
        movie.creationDate = Date()
        movie.title = entityMovie.title ?? ""
        movie.releaseDate = entityMovie.releaseDate ?? ""
        movie.poster = image?.jpegData(compressionQuality: 0.5)
        do {
            try dataController.viewContext.save()
            listIDs.append(entityMovie.id ?? 0)
        }catch {
            print(error.localizedDescription)
        }

    }
}
