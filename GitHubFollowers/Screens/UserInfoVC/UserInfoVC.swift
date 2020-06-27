//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/26/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    let headerView   = UIView() // explanation this header is the container for UserHeaderVC --> casue this UserHeaderVC is type VC i used it to make use of life cycle method and perform the composition which resolve MVC problem  i will add UserHeaderVC to headerView
    
    let itemViewOne  = UIView()
    let itemViewTwo  = UIView()
    let dateLable    = GFBodyLable(textAlignment: .center)
    
    
    var itemViewsList :[UIView] = [] // to put all this views in it to decrease the code
    
    var userName : String!
    var user : User?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControler()
        layoutUI()
        getUserInfo()
        
        
    }
    
    func getUserInfo() {
        //[unowned  self]  this force unwrape self
        NetworkManager.shared.getUserInfo(for: userName!) { [weak  self] (result) in
            // [weak  self] this makes self is optional
            guard let self = self else {return}
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                  //  print(user)// now u r free to use this user this is the result
                    //self.user = user
                    self.add(childVC:GFUserHeaderVC(user: user) , to: self.headerView)
                    
                    self.add(childVC : GFRepoItemVC(user: user) , to: self.itemViewOne)
                    
                    self.add(childVC : GFFollowerItemVC(user : user) , to: self.itemViewTwo)
                    
            self.dateLable.text = "GitHub since \(user.createdAt.convertToDisplayFormate())"
                }
                
                
                
            case .failure(let error): self.presentGFAlertyOnMainThread(title: "Something Went Wrong ", message: error.rawValue, buttonTitle: "OK")
                break
            }
            
            
        }
        
    }
    func configureViewControler() {
        
        view.backgroundColor = .systemBackground // this to show ur view if u didn't put a color for background it will appears transparent empty screen
        
        
        //**  i wil creat my cutom barbutton item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        // now we want to add the done button to the navigationBar
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func layoutUI()  {
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        itemViewsList = [headerView, itemViewOne , itemViewTwo , dateLable]
        
        for itemView in itemViewsList {
            
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
            
        }
        
//        itemViewOne.backgroundColor = .systemPink
//        itemViewTwo.backgroundColor = .systemPink
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 180) ,
            //itemviewone
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            //itemviewTwo
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            // dateLable
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 18)
            
        ])
        
    }
    
     //this function to add chiled VC to UIView --- then i take this UIView and add it as a component in the main VC like UserInfoVC
    func add(childVC : UIViewController , to containerView : UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame       = containerView.bounds
        childVC.didMove(toParent: self) // see help for more details about his method in a nutchel this must called if u create ur own container and added vc to it to make it interacte with the view
        
    }
    
    @objc func dismissVC()  {
        self.dismiss(animated: true)
    }
    
}
