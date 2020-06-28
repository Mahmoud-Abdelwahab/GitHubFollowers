//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame) /// appley apple customization on the button
        //Custom Code
        Configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    convenience init(backgroundColor : UIColor , title : String) {
        self.init(frame : .zero)
        self.backgroundColor  = backgroundColor
        self.setTitle(title, for: .normal)
        
    }
    
    private func Configure(){
        layer.cornerRadius                          = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font                            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints   = false // this to make u use auto layout
        
    }
    
    func set(backgroundColor : UIColor , title : String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        Configure()
    }
}
