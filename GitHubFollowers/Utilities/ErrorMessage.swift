//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//


/// the new way
enum  GFError : String , Error {
    
    case invalidUserName    = "This userName created an invaled request 😏 . please try again ."
    case unableToComplete   = "Unable to complete request please check your Internet connection 😏"
    case invalidResponse    = "Invalid Response from the server . Please try again "
    case invalidData        = "the data received from the server is invaled"
    case unableToFavourite  =  "There was an error favouriting this user 😵. Please try again ."
    case alreadyInFavourite = " You are alreadt like this user 🤔 "
}


//**********   this is the old way  ////
//enum ErrorMessage  : String {
//    /// to get the value in evey case like .invalidUserName use .rawValue
//    case invalidUserName    = "This userName created an invaled request . please try again ."
//
//    case unableToComplete   = "Unable to complete request please check ur iternet connection"
//
//
//    case invalidResponse    = "Invalid Response from the server . Please try again "
//
//    case invalidData        = "the data received from the server is invaled"
//}
