//
//  BaseViewController.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import UIKit

class BaseVC <T : UIView > : UIViewController , StatusApi {
    
    var refreshController : UIRefreshControl?
    
    func onError(_ message : String ){
           createAlert(text: message)
    }
    func onFailure (_ message : String ){
        createAlert(text: message)
    }
    func showLoading () {
        LoadingView.shared.showLoading(view: mainView)
    }
    func hideLoading () {
        LoadingView.shared.hideLoading()
    }
    
    
    
    
  override func loadView() {
      let t = T()
      t.backgroundColor = .white
      self.view = t
  }
  var mainView : T {
    if let view = self.view as? T {
      return view
    }else {
      let view = T()
      self.view = view
      return view
   
    }
  }
    
}
