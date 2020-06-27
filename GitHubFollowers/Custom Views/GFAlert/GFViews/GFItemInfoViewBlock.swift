//
//  GFItemInfoViewBlock.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

enum ItemInfoType { //  we will use this block components 4 times so i have to detect the type
    case repo , gists , followers , following
}



class GFItemInfoViewBlock: UIView {

  let symbolImageView   = UIImageView()
    let titleLable      = GFTitleLable(textAlignment: .left, fontSize: 14)
    let countlable      = GFTitleLable(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLable)
        addSubview(countlable)
        symbolImageView.translatesAutoresizingMaskIntoConstraints    = false
        symbolImageView.contentMode  = .scaleAspectFill
        symbolImageView.tintColor    = .label
        
    NSLayoutConstraint.activate([
        symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
        symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        symbolImageView.heightAnchor.constraint(equalToConstant: 20),
        symbolImageView.widthAnchor.constraint(equalToConstant: 20) ,
        
       
        titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
        titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
        titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        titleLable.heightAnchor.constraint(equalToConstant: 18),// this is repetition casue centerYanchor solved this
        
        countlable.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
        countlable.leadingAnchor.constraint(equalTo: self.leadingAnchor), ///// u can remove these two add centerX
        countlable.trailingAnchor.constraint(equalTo: self.trailingAnchor),/// u can remove these two add centerX
        countlable.heightAnchor.constraint(equalToConstant: 18),
        
    ])
        
    }
    
    
    
    /// this function  to pass the component enum type then  customise the componente based on it
    
    func set (iteminfoType : ItemInfoType , withCount count : Int){
        switch iteminfoType {
        case .repo:
            symbolImageView.image       = UIImage(systemName: SFSymbol.repos)
            titleLable.text             = "Public Repos"
            countlable.text             = String(count)
            break
           
        case .gists:
            symbolImageView.image       = UIImage(systemName: SFSymbol.gists)
            titleLable.text             = "Public Gists"
            countlable.text             = String(count)

            break
            
        case .followers:
            symbolImageView.image       = UIImage(systemName: SFSymbol.followers)
            titleLable.text             = "Followers"
            countlable.text             = String(count)

            break
            
        case .following:
            symbolImageView.image       = UIImage(systemName: SFSymbol.following)
            titleLable.text             = "Following"
            countlable.text             = String(count)

            break
            
        }
    }
}
