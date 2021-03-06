//
//  UserHeaderVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/26/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFUserHeaderVC: UIViewController {
    
    let avatarImageView      = GFAvatarImageView(frame: .zero)
    let usernameLable        = GFTitleLable(textAlignment: .left, fontSize: 34) //34 then height will be 38
    let nameLable            =  GFSecondaryTitleLable(fontSize: 18)
    let locationImageView    = UIImageView()
    let locationLable        = GFSecondaryTitleLable(fontSize: 18)
    let bioLable             = GFBodyLable(textAlignment: .left)
    
    var user :  User!
    
    init(user:User){
        super.init(nibName : nil , bundle : nil)
        self.user  = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(avatarImageView ,usernameLable ,nameLable ,locationImageView ,locationLable,bioLable)
        layoutUI()
        configureUIElements()
    }
    
    
    func configureUIElements(){
        avatarImageView.downloadAvatarImage(fromURL: user!.avatarUrl!) //safe unwraping
        usernameLable.text = user.login
        nameLable.text = user.name ?? ""
        locationLable.text = user.location ?? "No Location"
        bioLable.text      = user.bio ?? "No Bio Available"
        bioLable.numberOfLines = 3
        locationImageView.image = SFSymbol.location
        locationImageView.tintColor = .secondaryLabel
        
    }
    
    
    func layoutUI(){
        let padding : CGFloat = 20
        let textAvatarRightPadding  : CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            // usename constraints
            // the top to be aligned with avatarimage
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textAvatarRightPadding),
            usernameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLable.heightAnchor.constraint(equalToConstant: 38),
            nameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8) , //  a littel bit tricky right
            
            nameLable.leadingAnchor.constraint(equalTo : avatarImageView.trailingAnchor, constant: textAvatarRightPadding),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLable.heightAnchor.constraint(equalToConstant: 20),
            
            //  lication image view and location text
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textAvatarRightPadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            //location text
            locationLable.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLable.heightAnchor.constraint(equalToConstant: 20) ,
            /// setiting bio lable
            bioLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textAvatarRightPadding),
            bioLable.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLable.heightAnchor.constraint(equalToConstant:90)
        ])
    }
    
    
}
