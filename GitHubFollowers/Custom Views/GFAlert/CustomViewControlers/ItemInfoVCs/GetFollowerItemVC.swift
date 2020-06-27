//
//  GFFollowerItemVc.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//



// this class inherite from GFItemInfoVCSuperClass to perform some customization on it


// u can ignore this class and make this customization  in the super class -- GFItemInfoVCSuperClass  directly

/// *************** this class contains the top  carde ***************************////
///********************************************************************
class GFFollowerItemVC : GFItemInfoVCSuperClass {
    override func viewDidLoad() {
       super.viewDidLoad() // this is a must to call viewDidLoad from the parent 
        configureItems()
    }
    
    func configureItems(){
        itemViewOne.set(iteminfoType: .followers, withCount: user.followers)
        itemViewTwo.set(iteminfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    override func actionButtonTaped() {
           delegate.didTapGetFollowers(for: user)
       }
}
