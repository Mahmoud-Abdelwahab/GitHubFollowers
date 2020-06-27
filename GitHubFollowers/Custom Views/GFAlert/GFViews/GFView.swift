//
//  GFView.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFView: UIView {
        override init(frame: CGRect) {
            super.init(frame:frame)
             configure()
        }
        
//         init(textAlignment : NSTextAlignment , fontSize : CGFloat) {
//            super.init(frame : .zero )
//            self.textAlignment = textAlignment
//            self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
//            configure()
//        }
        
        private func configure(){
            backgroundColor           = .systemBackground
            layer.cornerRadius        = 16
            layer.borderWidth         = 2
            layer.borderColor         =  UIColor.white.cgColor
            translatesAutoresizingMaskIntoConstraints  = false
            
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
