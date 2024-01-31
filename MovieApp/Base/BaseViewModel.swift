//
//  BaseViewModel.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import Foundation

class BaseViewModel {
    
    var showLoading : ((Bool)->Void)? = nil
    var showError : ((String)->Void)? = nil

}
