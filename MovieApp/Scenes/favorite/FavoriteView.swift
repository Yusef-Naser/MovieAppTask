//
//  FavoriteView.swift
//  MovieApp
//
//  Created by yusef naser on 30/01/2024.
//

import UIKit

class FavoriteView : UIView {
    
    private var paddingCollectionView : CGFloat = 4.0
    private var heightConstantCell : CGFloat = 100
    
   
    lazy var tableView : UITableView = {
        let l = UITableView()
        l.register(CellMovie.self , forCellReuseIdentifier: CellMovie.getIdentifier() )
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
                
        tableView.topAnchor.constraint(equalTo: self.topAnchor , constant: 8).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 8).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -8).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -8).isActive = true
  
    }
    
    
    func setDelegate (vc : FavoriteVC) {
        tableView.delegate = vc
        tableView.dataSource = vc
    }
    
}
