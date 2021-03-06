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
    
    
    convenience init(textAlignment : NSTextAlignment) {
        self.init(frame : .zero )
        self.textAlignment                           = textAlignment
        
    }
    
    
    private func configure(){
        textColor                                    = .secondaryLabel
        adjustsFontSizeToFitWidth                    = true
        minimumScaleFactor                           = 075
        lineBreakMode                                = .byWordWrapping// this make text is execed line be like helloMyNameis mah...
        translatesAutoresizingMaskIntoConstraints    = false // this make text ne dynamic if u minimiz or max the text
        font                                         = UIFont.preferredFont(forTextStyle: .body) // this give us dynamic type
        adjustsFontForContentSizeCategory            = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
