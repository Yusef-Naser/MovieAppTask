//
//  HomeView.swift
//  MovieApp
//
//  Created by yusef naser on 27/01/2024.
//

import UIKit

class HomeView : UIView {
    
    private var paddingtableView : CGFloat = 4.0
    private var heightConstantCell : CGFloat = 100
    
    
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
        self.addSubview(tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.topAnchor , constant: 0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: paddingtableView).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -paddingtableView).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: 0).isActive = true
    }
    
    func setDelegate (vc : HomeVC) {
        self.tableView.delegate = vc
        self.tableView.dataSource = vc
    }
    
}
