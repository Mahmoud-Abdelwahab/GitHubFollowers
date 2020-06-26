//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/26/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
 
    var userName : String!
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // this to show ur view if u didn't put a color for background it will appears transparent empty screen
    
        
        //**  i wil creat my cutom barbutton item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        // now we want to add the done button to the navigationBar
        navigationItem.rightBarButtonItem = doneButton
        print(userName!)
                                                 //[unowned  self]  this force unwrape self
        NetworkManager.shared.getUserInfo(for: userName!) { [weak  self] (result) in
             // [weak  self] this makes self is optional
            guard let self = self else {return}
            switch result {
            case .success(let user): print(user)// now u r free to use this user this is the result
            self.user = user
                
            
            case .failure(let error): self.presentGFAlertyOnMainThread(title: "Something Went Wrong ", message: error.rawValue, buttonTitle: "OK")
                break
            }
            
            
        }
        
    }
    
    @objc func dismissVC()  {
        self.dismiss(animated: true)
    }

}
