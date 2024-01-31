//
//  SearchVC.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import UIKit

class SearchVC : BaseVC<SearchView> {
    
    var viewModel : SearchViewModel?
    var debouncer = Debouncer(delay: 2)
    
    var dataController : DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Search"
        viewModel = SearchViewModel(useCase: SearchUseCase(repo: SearchRepository()))
        callBacks()
        mainView.setDelegate(vc: self)
        
    }
    
}

extension SearchVC {
    
    func callBacks () {
        viewModel?.showLoading = { b in
            if b {
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
        }
    }
    
}

extension SearchVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel?.callPaginate(index: indexPath.row)
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getMoviesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellMovie.getIdentifier() , for: indexPath) as! CellMovie
        cell.imageMovies.isHidden = true 
        viewModel?.configurationMovies(cell: cell , index: indexPath.row)
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(MovieDetailsVC(movieID: viewModel?.getItem(index: indexPath)?.id ?? 0) , animated: true )
    }

    
}

extension SearchVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mainView.endEditing(true)
        debouncer.debounce {
            guard let text = searchBar.text , text.count > 0 else {
                return
            }
            self.viewModel?.searchMovies(text: text)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debouncer.debounce {
            self.viewModel?.searchMovies(text: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.mainView.endEditing(true)
    }
    
}
