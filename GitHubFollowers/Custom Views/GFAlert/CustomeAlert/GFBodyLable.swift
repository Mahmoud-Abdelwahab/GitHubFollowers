//
//  GFBodyLable.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFBodyLable: UILabel {
       override init(frame: CGRect) {
            super.init(frame:frame)
             configure()
        }
        
         init(textAlignment : NSTextAlignment) {
            super.init(frame : .zero )
            self.textAlignment = textAlignment
            configure()
        }
        
        private func configure(){
            textColor = .secondaryLabel
            adjustsFontSizeToFitWidth = true
            minimumScaleFactor        = 0.9
            lineBreakMode             = .byWordWrapping// this make text is execed line be like   helloMyNameis mah...
            translatesAutoresizingMaskIntoConstraints  = false
            font                      = UIFont.preferredFont(forTextStyle: .body)
            
        }
        
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
    }
