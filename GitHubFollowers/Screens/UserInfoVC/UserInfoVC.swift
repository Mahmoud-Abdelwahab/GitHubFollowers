//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/26/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

// this protocole s for geting followers form UserInfoVC
protocol UserInfoVCDelegate : class {
    func didRequestFollowers(for username : String)
}


class UserInfoVC: UIViewController {
    
    var delegate : UserInfoVCDelegate!
    /*****************************************/
    //this scrollVIew i made to solve the iphoneSE samll screen speaces
    // i made a container view which will hold all the view then add this container viw to the scroll view
    let scrollView   = UIScrollView()
    let containerView    = UIView()
    //******************************************//
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
        configureScrollView()
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
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        scrollView.pinToTheEdges(of: view) // pinToTheEdges this is my custom func which i made in th uiviewExtention to put the ful screen constriants for any superview i send to it
        containerView.pinToTheEdges(of: scrollView)
        
          NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 600) // this is the height fro th e scroll view i will put it with the hieght of iphoneSE
          ])
        
    }
    
    func configureUIElements(with user : User) {
        //  print(user)// now u r free to use this user this is the result
        //self.user = user
        self.add(childVC:GFUserHeaderVC(user: user) , to: self.headerView)
        
        self.add(childVC :GFRepoItemVC(user: user, delegate: self) , to: self.itemViewOne)

        let gfFollowers =  GFFollowersItemVC(user: user)
            gfFollowers.delegate = self
        self.add(childVC : gfFollowers , to: self.itemViewTwo)
        
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
            
            containerView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                
                itemView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding)
            ])
            
        }
        
        //        itemViewOne.backgroundColor = .systemPink
        //        itemViewTwo.backgroundColor = .systemPink
        
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: containerView.topAnchor),
            
            headerView.heightAnchor.constraint(equalToConstant: 210) ,
            //itemviewone
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            //itemviewTwo
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            
            // dateLable
            dateLable.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 50)
            
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

extension UserInfoVC : GFRepoItemVCDelegate{
    func didTapGitHubProfile(for user: User) {
        print("user profile taped ")
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertyOnMainThread(title: "Invalid URl", message: "The URL attached to this user is invaled ", buttonTitle: "OK!")
            return
        }
        presentSafariVC(with: url) // safari VC now it open in the existing app it does't cose my app to open anther app( safari) but it's now incuded in our app u will botice that the tint color which we put to it green
    }
    
    
    
}

extension UserInfoVC : GFFollowerItemVCDelegate{
    func didTapGetFollowers(for user: User) {
        print("user Followers taped ")
        
        guard  user.followers > 0  else {
            
            presentGFAlertyOnMainThread(title: "No Followers ", message: "This user has no followers . What a shame 😢 ", buttonTitle: "Ok!")
            return
        }
        delegate.didRequestFollowers(for: user.login!)
        dismissVC()
    }
    
    
    
}

