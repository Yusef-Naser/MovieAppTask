//
//  Utilities.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import UIKit

protocol StatusApi : AnyObject {
   func onError(_ message : String )
   func onFailure (_ message : String )
   func showLoading ()
   func hideLoading ()
}

enum OrientationMovies {
    case grid
    case list
}

enum TypeMovies {
    case popular
    case topRated
}

struct Constants {
    
    static let URL = "https://api.themoviedb.org/3/"
    static let API_KEY = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNDk5MTU2NTEyOWZmMDMxOGJjMzE5YzdhNTIyNzg5OSIsInN1YiI6IjU3OWIxN2EwOTI1MTQxNGNkMzAwNmExZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.x4v4TkkFUUiYHzvPMn0zpVcggLS4vHaemCJCHGQegSc"
    
}


extension UITableViewCell {
    
    static func getIdentifier() -> String {
        String(describing: self)
    }
    
}
