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
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl : String
    let followers: Int
    let following: Int
    // let createdAt : String  // this is a date so u decodar can decode it automatically to date decoder.dateDecodeStratigy = .0iso8601  this is th standared but u can search about it
    let createdAt : Date
    
    /***   hashable returns unique consestant id  for each instatance */
    
    /// if u want to make only on variable is hashable  shoe the below code
    
    //    func hash(into hasher : inout Hasher) {
    //        hasher.combine(login)
    //    }
}
