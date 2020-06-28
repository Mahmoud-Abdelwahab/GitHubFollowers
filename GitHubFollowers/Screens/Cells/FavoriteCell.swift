//
//  FavoriteCell.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let reuseID         = "FavoriteCell"
    let avatarImageView        = GFAvatarImageView(frame: .zero)
    let userNameLable          = GFTitleLable(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    // this is storyboard initializer
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        addSubviews(avatarImageView,userNameLable)
        // then to add the accessoray which like [>] at the end on the cell write below code
        accessoryType               = .disclosureIndicator  // disclosureIndicator this show arrow which mean tap here and there is more to see
        let padding : CGFloat       = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            
            userNameLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            userNameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            userNameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            userNameLable.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    // setting the cell with data
    func set(favorite : Follower)  {
        userNameLable.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl!) {[weak self] (image) in
            guard let self = self else {return}
            DispatchQueue.main.async {self.avatarImageView.image = image}
        }
        
    }
    
}
