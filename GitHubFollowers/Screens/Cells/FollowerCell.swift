//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by kasper on 6/25/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    let padding :CGFloat = 8
    static let reuseID = "FollowerCell"
    let avatarImageView   = GFAvatarImageView(frame: .zero)

    let userNameLable = GFTitleLable(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configurAvatarImageView()
        configurUserNameLable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower : Follower)  {
        userNameLable.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl!)
    }
    
    func configurAvatarImageView(){
        addSubview(avatarImageView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding) ,
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding) ,
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding) ,
            // equal width and height
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
    }
    
    func  configurUserNameLable() {
        addSubview(userNameLable)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            userNameLable.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding) ,
            userNameLable.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userNameLable.heightAnchor.constraint(equalToConstant: 20) // here height is 20 casue to give the lable some padding casue the lable font above is 16
            
        ])
    }
}
