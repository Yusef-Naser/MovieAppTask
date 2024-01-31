//
//  Extensions.swift
//  MovieApp
//
//  Created by yusef naser on 29/01/2024.
//

import UIKit

extension UIScrollView {
    func addRefreshController() -> UIRefreshControl {
        let r = UIRefreshControl()
      //  r.attributedTitle = NSAttributedString(string: SString.loading )
        self.refreshControl = r
        self.addSubview(r)
        return r
    }
}

extension UIViewController {
    
    func createAlert (text : String) {
        let alert = UIAlertController(title: nil , message: text , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
}
