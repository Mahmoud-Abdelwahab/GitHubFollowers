//
//  UIView+Ext.swift
//  GitHubFollowers
//
//  Created by kasper on 6/28/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit
/// this extention for  optimizing the addsubview() methode casue we use it alot
//********* ***** **** i will use advanced topic called [** Variadic parameter**]
extension UIView {
    func addSubviews(_ views : UIView...) {
        /// UIView... this means that u can pass anynumber f the parameters from this type
        for view in views {addSubview(view) }
    }
    
    
    /********** General constraints pin view to the edgs  i used it  to constraints the scroll view  ******************/
    
    func pinToTheEdges(of superView : UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview!.topAnchor),
            leadingAnchor.constraint(equalTo: superview!.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview!.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview!.bottomAnchor),
        ])
    }
}
