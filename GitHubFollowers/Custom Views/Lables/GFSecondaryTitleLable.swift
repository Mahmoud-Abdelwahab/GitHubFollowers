//
//  GFSecondaryTitleLable.swift
//  GitHubFollowers
//
//  Created by kasper on 6/26/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFSecondaryTitleLable: UILabel {
    override init(frame: CGRect) {
              super.init(frame:frame)
               configure()
          }
          
           init(fontSize : CGFloat) {
              super.init(frame : .zero )
            self.font = UIFont.systemFont(ofSize: fontSize, weight : .medium)
              configure()
          }
          
          private func configure(){
              textColor = .secondaryLabel
              adjustsFontSizeToFitWidth = true
              minimumScaleFactor        = 0.9
              lineBreakMode             = .byTruncatingTail//  mah...
              translatesAutoresizingMaskIntoConstraints  = false
          }
          
          
          required init?(coder: NSCoder) {
              fatalError("init(coder:) has not been implemented")
          }
          
          
      }
