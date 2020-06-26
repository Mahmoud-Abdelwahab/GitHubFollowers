//
//  GFTextField.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 10
        layer.borderWidth                           = 2
        layer.borderColor                           = UIColor.systemGray4.cgColor
        textColor                                   = .label // here the text color with be white on dark mode and black on white mode
        tintColor                                   = .label
        textAlignment                               = .center
        font                                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth                   = true
        minimumFontSize                             = 12
      //  keyboardType                                = .emailAddress
        returnKeyType                               = .go  // not here to set up go  , next , action button on the keyboard  and in the code i will handel click action on this button
        backgroundColor                             = .tertiarySystemBackground
        autocorrectionType                          = .no
        placeholder                                 = "Enter your UserName "
    }
}
