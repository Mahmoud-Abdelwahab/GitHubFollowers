//
//  GFItemInfoVcSubClass.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit
protocol GFRepoItemVCDelegate :class {
    func didTapGitHubProfile(for user : User)
    //this protocole to listen the button action casue button dosn't exists here in the UserInfoVC
}

// this class inherite from GFItemInfoVCSuperClass to perform some customization on it


// u can ignore this class and make this customization  in the super class -- GFItemInfoVCSuperClass  directly

/// *************** this class contains the top  carde ***************************////
///********************************************************************
class GFRepoItemVC : GFItemInfoVCSuperClass {
    
    weak var delegate : GFRepoItemVCDelegate!
    
    init(user :User , delegate : GFRepoItemVCDelegate ) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()// this is a must to call viewDidLoad from the parent 
        configureItems()
    }
    
    func configureItems(){
        itemViewOne.set(iteminfoType: .repo, withCount: user.publicRepos)
        itemViewTwo.set(iteminfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    override func actionButtonTaped() {
        delegate.didTapGitHubProfile(for: user)
    }
}
