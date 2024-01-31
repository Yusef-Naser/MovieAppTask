//
//  SearchView.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import UIKit

class SearchView : UIView {
    
    private var paddingtableView : CGFloat = 4.0
    private var heightConstantCell : CGFloat = 100
    
    private let searchView : UISearchBar = {
        let l = UISearchBar()
        l.showsCancelButton = true
        
        return l
    }()
    
  
    lazy var tableView : UITableView = {
        let l = UITableView()
        l.register(CellMovie.self , forCellReuseIdentifier: CellMovie.getIdentifier())
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
    }
    
    func addConstraints () {
        
        let guide = self.safeAreaLayoutGuide
        
        self.addSubview(searchView)
        self.addSubview(tableView)
        
        self.searchView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.searchView.topAnchor.constraint(equalTo: guide.topAnchor , constant: 0 ).isActive = true
        self.searchView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        self.searchView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        tableView.topAnchor.constraint(equalTo: self.searchView.bottomAnchor , constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 8).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -8).isActive = true
        
    }
    
    func setDelegate (vc : SearchVC) {
        tableView.delegate = vc
        tableView.dataSource = vc
        searchView.delegate = vc 
    }
    
}
