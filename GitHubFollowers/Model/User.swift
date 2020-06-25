//
//  User.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import Foundation

struct User : Codable {
    var login : String?
    var avatarUrl : String?
    var name : String?
    var location : String?
    var bio : String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl : String
    var followers: Int
    var following: Int
    var createdAt : String
    
    
      /***   hashable returns unique consestant id  for each instatance */
        
        /// if u want to make only on variable is hashable  shoe the below code
        
    //    func hash(into hasher : inout Hasher) {
    //        hasher.combine(login)
    //    }
}
