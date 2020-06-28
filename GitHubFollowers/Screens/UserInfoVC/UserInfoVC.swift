//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/26/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate :class {
    func didTapGitHubProfile(for user : User)
    func didTapGetFollowers(for user : User)
    //this protocole to listen the button action casue button dosn't exists here in the UserInfoVC
}

class UserInfoVC: UIViewController {
    
    var delegate : FollowerlistVCDelegate!
    
    
    let headerView   = UIView() // explanation this header is the container for UserHeaderVC --> casue this UserHeaderVC is type VC i used it to make use of life cycle method and perform the composition which resolve MVC problem  i will add UserHeaderVC to headerView
    
    let itemViewOne   = UIView()
    let itemViewTwo   = UIView()
    let dateLable     = GFBodyLable(textAlignment: .center)
    
    
    var itemViewsList : [UIView] = [] // to put all this views in it to decrease the code
    
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
                DispatchQueue.main.async {self.configureUIElements(with : user )}
                
                
                
            case .failure(let error): self.presentGFAlertyOnMainThread(title: "Something Went Wrong ", message: error.rawValue, buttonTitle: "OK")
                break
            }
            
            
        }
        
    }
    
    
    func configureUIElements(with user : User) {
        //  print(user)// now u r free to use this user this is the result
        //self.user = user
        self.add(childVC:GFUserHeaderVC(user: user) , to: self.headerView)
        
        let gFRepoItemVC = GFRepoItemVC(user: user)
        gFRepoItemVC.delegate = self
        
        self.add(childVC :gFRepoItemVC , to: self.itemViewOne)
        
        let gFFollowerItemVC = GFFollowerItemVC(user: user)
        gFFollowerItemVC.delegate = self
        
        self.add(childVC : gFFollowerItemVC , to: self.itemViewTwo)
        
        self.dateLable.text = "GitHub since \(user.createdAt.convertToMonthYearFormate())"
    }
    
    func configureViewControler() {
        
        view.backgroundColor = .systemBackground // this to show ur view if u didn't put a color for background it will appears transparent empty screen
        
        
        //**  i wil creat my cutom barbutton item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        // now we want to add the done button to the navigationBar
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func layoutUI()  {
        let padding    : CGFloat = 20
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

//// handling buttons
extension UserInfoVC : UserInfoVCDelegate{
    func didTapGitHubProfile(for user : User) {
        print("user profile taped ")
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertyOnMainThread(title: "Invalid URl", message: "The URL attached to this user is invaled ", buttonTitle: "OK!")
            return
        }
        presentSafariVC(with: url) // safari VC now it open in the existing app it does't cose my app to open anther app( safari) but it's now incuded in our app u will botice that the tint color which we put to it green 
    }
    
    func didTapGetFollowers(for user : User) {
        print("user Followers taped ")
        
        guard  user.followers > 0  else {
            
            presentGFAlertyOnMainThread(title: "No Followers ", message: "This user has no followers . What a shame 😢 ", buttonTitle: "Ok!")
            return
        }
        delegate.didRequestFollowers(for: user.login!)
        dismissVC()
    }
    
    
    
}
