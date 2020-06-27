//
//  GFItemInfoVcSubClass.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit


// this class inherite from GFItemInfoVCSuperClass to perform some customization on it


// u can ignore this class and make this customization  in the super class -- GFItemInfoVCSuperClass  directly

/// *************** this class contains the top  carde ***************************////
///********************************************************************
class GFRepoItemVC : GFItemInfoVCSuperClass {
    
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
