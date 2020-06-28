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

protocol GFFollowerItemVCDelegate :class {
    
    func didTapGetFollowers(for user : User)
    //this protocole to listen the button action casue button dosn't exists here in the UserInfoVC
}



class GFFollowersItemVC : GFItemInfoVCSuperClass {
    
    weak var delegate : GFFollowerItemVCDelegate!
    
    //       init(user :User , delegate : GFFollowerItemVCDelegate ) {
    //           super.init(user: user)
    //           self.delegate = delegate
    //       }
    //    
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    // i don't know why this code case error however it's working in it's brother
    
    
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
