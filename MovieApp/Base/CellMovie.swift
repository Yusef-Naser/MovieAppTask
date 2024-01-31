//
//  CellMovie.swift
//  MovieApp
//
//  Created by yusef naser on 28/01/2024.
//

import UIKit
import PINRemoteImage


protocol ConfigurationCellMovie {
    func setData (urlString : String? , name : String? , releaseDate : String? , isFavorite : Bool? )
    func setData (image : Data? , name : String? , releaseDate : String? , isFavorite : Bool? )
}

protocol CellMovieDelegate {
    func favoriteButton(cell : CellMovie)
}

class CellMovie : UITableViewCell , ConfigurationCellMovie {
    
    var delegateCellMovie : CellMovieDelegate?
    
    let imageMovies : UIImageView = {
        let l = UIImageView()
        
        return l
    }()
    
    private let labelName : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
    private let labelReleaseDate : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
        return l
    }()
    
    let favoriteButton : UIButton = {
        let l = UIButton()
        l.setImage(UIImage(systemName: "star" ), for: .normal)
        return l
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        initViews()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    func initViews () {
        addConstraints()
        favoriteButton.addTarget(self , action: #selector(actionFavorite), for: .touchUpInside)
    }
    
    func addConstraints () {
        
                
        self.contentView.addSubview(imageMovies)
        self.contentView.addSubview(labelName)
        self.contentView.addSubview(labelReleaseDate)
        self.contentView.addSubview(favoriteButton)
        
        imageMovies.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        
        imageMovies.topAnchor.constraint(equalTo: self.contentView.topAnchor , constant: 0).isActive = true
        imageMovies.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor , constant: 0).isActive = true
        imageMovies.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor , constant: 0).isActive = true
        
        imageMovies.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageMovies.widthAnchor.constraint(equalTo: imageMovies.heightAnchor , multiplier: 0.8).isActive = true
        
        
        favoriteButton.topAnchor.constraint(equalTo: self.imageMovies.topAnchor , constant: 0).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: 0).isActive = true
        
        favoriteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        favoriteButton.widthAnchor.constraint(equalTo: imageMovies.heightAnchor , multiplier: 1).isActive = true
        
        
        
        labelName.topAnchor.constraint(equalTo: self.favoriteButton.bottomAnchor , constant: 4).isActive = true
        labelName.leadingAnchor.constraint(equalTo: self.imageMovies.trailingAnchor , constant: 4).isActive = true
        labelName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: 0).isActive = true
        
        labelReleaseDate.topAnchor.constraint(equalTo: self.labelName.bottomAnchor , constant: 0).isActive = true
        labelReleaseDate.leadingAnchor.constraint(equalTo: self.imageMovies.trailingAnchor , constant: 4).isActive = true
        labelReleaseDate.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: 0).isActive = true
        labelReleaseDate.bottomAnchor.constraint(lessThanOrEqualTo: self.contentView.bottomAnchor , constant: -8).isActive = true
        
        
    }
    
    func setData (urlString : String? , name : String? , releaseDate : String? , isFavorite : Bool? ) {
        labelName.text = name
        labelReleaseDate.text = releaseDate
        imageMovies.pin_setImage(from: URL(string: urlString ?? "" ) , placeholderImage: UIImage(named: "placeholder"))
        
        if let isFavorite = isFavorite , isFavorite {
            favoriteButton.imageView?.image = UIImage(systemName: "star.fill")
        } else {
            favoriteButton.imageView?.image = UIImage(systemName: "star")
        }
    }
    
    func setData (image : Data? , name : String? , releaseDate : String? , isFavorite : Bool? ) {
        labelName.text = name
        labelReleaseDate.text = releaseDate
        
        if let isFavorite = isFavorite , isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star") , for: .normal)
        }
        
        guard let data = image else {
            imageMovies.image = UIImage(named: "placeholder")
            return
        }
        imageMovies.image = UIImage(data: data)
        
    }
    
    @objc private func actionFavorite () {
        
        delegateCellMovie?.favoriteButton(cell: self )
    }
    
    
}
