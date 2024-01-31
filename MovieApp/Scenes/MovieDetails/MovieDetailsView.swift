//
//  MovieDetailsView.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import UIKit
import PINRemoteImage

class MovieDetailsView : UIView {
    
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.addSubview(self.contentView)
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: scroll.topAnchor).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor).isActive = true
       
        self.contentView.widthAnchor.constraint(equalTo: scroll.widthAnchor, multiplier: 1).isActive = true
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let imagePoster : UIImageView = {
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
    
    private let labelDescription  : UILabel = {
        let l = UILabel()
        l.numberOfLines = 0
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
        self.addSubview(scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.contentView.addSubview(imagePoster)
        self.contentView.addSubview(labelName)
        self.contentView.addSubview(labelReleaseDate)
        self.contentView.addSubview(labelDescription)
        
        imagePoster.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        
        imagePoster.topAnchor.constraint(equalTo: self.contentView.topAnchor , constant: 8).isActive = true
        imagePoster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor , constant: 8).isActive = true
        imagePoster.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor , constant: -8).isActive = true
        imagePoster.heightAnchor.constraint(equalToConstant: 200).isActive = true
    
        labelName.topAnchor.constraint(equalTo: imagePoster.bottomAnchor , constant: 8).isActive = true
        labelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8).isActive = true
        labelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -8).isActive = true
        
        
        labelReleaseDate.topAnchor.constraint(equalTo: labelName.bottomAnchor , constant: 8).isActive = true
        labelReleaseDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8).isActive = true
        labelReleaseDate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        labelDescription.topAnchor.constraint(equalTo: labelReleaseDate.bottomAnchor , constant: 8).isActive = true
        labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: 8).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor , constant: -8).isActive = true
        labelDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: 16).isActive = true
        
        
    }
    
    
    func setData (poster : String? , title : String? , releaseData : String? , overView : String? ) {
        
        labelName.text = title
        labelReleaseDate.text = releaseData
        labelDescription.text = overView
        imagePoster.pin_setImage(from: URL(string: poster ?? "" ) , placeholderImage: UIImage(named: "placeholder"))
    }
    
}
