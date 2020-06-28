//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView            = UIImageView()
    
    let userNameTextFiled        = GFTextField()
    
    let CallToActionButton       = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    
    // this is computed property
    var isUserNameEmpty : Bool {return !userNameTextFiled.text!.isEmpty}
    
    //! cause isEmplty returns true if text has no charachter  so we want to check false case  [if not empty return true]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // for dark mode it  will be white for the white mode it will be black
        
        ConfiguringLogoImageView()
        ConfiguringTextField()
        ConfiguringCallToActionButton()
        creatDismissKeyboardTapGesture()
        
        //
        //        let email = "mahmoud@gmail.com"
        //        print(email.isValidEmail)
        //
        //        let pass = "Ma7oda%_025"
        //        print(pass.isValidPassword)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userNameTextFiled.text = ""
        /****** ********/
        // hide Navigation bar
        //  self.navigationController?.isNavigationBarHidden = true  // this is the best place for it but this does'nt make animations  the below code make it
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    
    // to dismiss keyboard
    func creatDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func pushFollowerListVc()
    {
        guard isUserNameEmpty else {
            print("No text ")
            presentGFAlertyOnMainThread(title: "Alert", message: "Please Enter a UserName🤠", buttonTitle:"OK")
            return
        }
        
        //dismiss the keyboard
        userNameTextFiled.resignFirstResponder() //this dismiss the keyboard or you can use  userNameTextFiled.endEditing(true)
        
        let followerListVC      = FollowersListVC(username: userNameTextFiled.text!)// force safe unrapping here because i check if isUserNameEmpty above
        
        
        
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    
    func  ConfiguringCallToActionButton() {
        view.addSubview(CallToActionButton)
        
        CallToActionButton.addTarget(self, action: #selector(pushFollowerListVc), for: .touchUpInside)
        
        CallToActionButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            CallToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50) ,
                                       
            CallToActionButton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant: 50),
            CallToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50) ,
            CallToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    
    func ConfiguringLogoImageView()  {
        view.addSubview(logoImageView) // this line is equale to using storyboard and this ;line must palced before configuring the view like below
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image    = Images.ghLogo ////  I made  enum contains all images in the constant file
        
        
        let topConstantConstraints : CGFloat = DeviceTypes.isiPhoneSE||DeviceTypes.isiPhone8Zoomed ? 20 :80
        // i will change top constatints according to the device type
        
     
        // to set th e constrains for imageview
        NSLayoutConstraint.activate([
            // logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstantConstraints),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    
    func ConfiguringTextField()  {
        
        view.addSubview(userNameTextFiled)
        
        userNameTextFiled.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTextFiled.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48)
            ,
            userNameTextFiled.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant:50)
            , userNameTextFiled.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
            , userNameTextFiled.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
    
    
    
    
}


extension SearchVC  : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(" go button clicked ")
        pushFollowerListVc()  // this function called if user hit go button in keyboard OR hit getFollowers Button
        
        return true
    }
    
    
    
    
}



