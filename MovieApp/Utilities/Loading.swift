//
//  Loading.swift
//  MovieApp
//
//  Created by yusef naser on 31/01/2024.
//

import UIKit

class LoadingView : UIView {
    
    static var shared = LoadingView()
    
    
    private let activityController : UIActivityIndicatorView = {
        let l = UIActivityIndicatorView()
        
        return l
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    func initViews () {
        addConstraints()
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.3)
    }
    
    func addConstraints () {
        self.addSubview(activityController)
        activityController.translatesAutoresizingMaskIntoConstraints = false
        activityController.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityController.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func showLoading(view : UIView) {
        view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        activityController.startAnimating()
    }
    
    
    func hideLoading(){
        activityController.stopAnimating()
        self.removeFromSuperview()
    }
}
