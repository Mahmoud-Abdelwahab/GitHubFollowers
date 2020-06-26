//
//  GFEmptyView.swift
//  GitHubFollowers
//
//  Created by kasper on 6/25/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFEmptyView: UIView {

    let messageLable   = GFTitleLable(textAlignment: .center, fontSize: 28)
    let logoImageView  = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    init(message : String) {
        super.init(frame:.zero)
        messageLable.text = message
           configure()
       }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
   private func configure() {
        addSubview(messageLable)
        addSubview(logoImageView)
        
        messageLable.numberOfLines                 = 3
        messageLable.textColor                     = .secondaryLabel
        
        logoImageView.image                        = UIImage(named: "gitHubLogo")
    //   don't forget to but translatesAutoresizingMaskIntoConstraints  = false  for any view u add constatints to it  if  the view is hidden so make sure that this line is exists
        logoImageView.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-40) ,
            messageLable.heightAnchor.constraint(equalToConstant: 200) ,
            
            ///logo iMage constrains
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            //this is the view width self.widthAnchor
            // take view width then multiply it with 1.3 of the screen   this multipler  aspect ratio
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3)
            ,
              logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 190),
              logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 60)
            
            
        ])
    }
    
}
