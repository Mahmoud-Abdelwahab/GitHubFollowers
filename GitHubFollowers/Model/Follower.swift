//
//  Follower.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import Foundation

struct Follower : Codable {
    var login : String?
   // var avatar_url : String  // not codebel the var must be the same as in the api
    // [ but ] if there is _ underscore in the var u can write it in the camelCase
    // avatar_url ---> [avatarUrl] only this and codable automaticaly convert
    // sanck_case to camelCase
    //u need to put his line in the decoder    decoder.keyDecodingStrategy = .convertFromSnakeCase 
    var avatarUrl : String?
    
}
