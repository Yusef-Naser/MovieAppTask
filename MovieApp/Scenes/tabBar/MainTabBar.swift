//
//  MainTabBar.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import UIKit

class MainTabBar : UITabBarController {
    
    let discover = Router.createHomeVC()
    let favorite = Router.createFavoriteVC()
       
    
       override func viewDidLoad() {
           super.viewDidLoad()
           
          
           navigationItem.rightBarButtonItem = getSearchButtonItem()
           
           discover.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill") , tag: 0)
           discover.navigationItem.title = "Home"
           
           
           favorite.tabBarItem =  UITabBarItem(title: "Favorite", image: UIImage(systemName: "star") , tag: 1)
           favorite.navigationItem.title = "Favorite"
           favorite.navigationItem.searchController = UISearchController()
           viewControllers = [discover , favorite ]
           
           delegate = self
           
       }

    @objc private func SortTapped () {
        let alert = UIAlertController(title: "Select Sort", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: SortMovies.popularity_asc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.popularity_asc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.popularity_desc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.popularity_desc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.revenue_asc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.revenue_asc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.revenue_desc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.revenue_desc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.primary_release_date_asc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.primary_release_date_asc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.primary_release_date_desc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.primary_release_date_desc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.vote_average_asc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.vote_average_asc)
        }))
        alert.addAction(UIAlertAction(title: SortMovies.vote_average_desc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.vote_average_desc)
        }))
        
        alert.addAction(UIAlertAction(title: SortMovies.vote_count_asc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.vote_count_asc)
        }))
        alert.addAction(UIAlertAction(title: SortMovies.vote_count_desc.rawValue, style: .default , handler:{ (UIAlertAction)in
            self.discover.setSort(sort: SortMovies.vote_count_desc)
        }))
        
        //uncomment for iPad Support
        //alert.popoverPresentationController?.sourceView = self.view

        self.present(alert, animated: true, completion: {
           
        })
    }
    func getSortButtonItem() -> UIBarButtonItem {
        UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(SortTapped))
    }
    
    func getSearchButtonItem() -> UIBarButtonItem {
        UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(searchTapped))
    }
    
    @objc private func searchTapped () {
        self.navigationController?.pushViewController(SearchVC() , animated: true )
    }
   

}



extension MainTabBar : UITabBarControllerDelegate {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
            navigationItem.rightBarButtonItems = [getSearchButtonItem() , getSortButtonItem()]
        }else {
            navigationItem.rightBarButtonItems = []
            navigationItem.rightBarButtonItem = getSearchButtonItem()
        }
        
    }
    
}
