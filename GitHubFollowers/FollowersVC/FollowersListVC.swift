//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    var userName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
   
       
 navigationController?.navigationBar.prefersLargeTitles = true // to make navigationbar title large
        // Do any additional setup after loading the view.
        
        
        
        
        /***     this is th e old way */
//        NetworkManager.shared.getFollowers(for: userName!, page: 1) { (followers, errorMessage) in
//
//            guard let followers = followers else {
//                 /// to get the value in evey case like .invalidUserName use .rawValue
//                self.presentGFAlertyOnMainThread(title: "Bad Stuff happened ", message: errorMessage!.rawValue, buttonTitle: "OK")
//                 return
//            }
//
//            print(followers)
//            print( "the followers count \(followers.count)")
//        }
        
         // this is the new way using Result in swift 5
        NetworkManager.shared.getFollowers(for: userName!, page: 1) { (result) in
               
            switch result
            {
            case . success(let followers) :    print(followers)  ;  print( "the followers count \(followers.count)")
                
            case .failure(let error):self.presentGFAlertyOnMainThread(title: "Bad Stuff happened ", message: error.rawValue, buttonTitle: "OK")
            }
            
        
           }
    }
    
    override func viewWillAppear(_ animated: Bool) {
             //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)

    }
   

}
