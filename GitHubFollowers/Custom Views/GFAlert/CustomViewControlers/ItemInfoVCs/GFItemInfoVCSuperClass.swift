//
//  GFItemInfoVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFItemInfoVCSuperClass: UIViewController {
    
    weak var delegate : UserInfoVCDelegate!

    let stackView       = UIStackView()
    let itemViewOne     = GFItemInfoViewBlock()
    let itemViewTwo     = GFItemInfoViewBlock()
    let actionButton    = GFButton()
    
    
    var user :  User!

        init(user:User){
           super.init(nibName : nil , bundle : nil)
           self.user  = user
             }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurBakegroundView()
        layoutUI()
        configureStackView()
         configureActionButton ()
        
    }
    
    
    func configureActionButton (){
        actionButton.addTarget(self, action: #selector(actionButtonTaped), for: .touchUpInside)
    }
    
    @objc func actionButtonTaped(){} // i will overried this func in the sub classes[GetRepoItem , GetFollowerItem ]
    
  private  func configurBakegroundView()  {
        view.layer.cornerRadius   = 18
              view.backgroundColor      = .secondarySystemBackground // this give a light gray background  color
    }
   
    private func configureStackView(){
        stackView.axis                       = .horizontal
        stackView.distribution               = .fillEqually
       // stackView.spacing                    = 10
        stackView.addArrangedSubview(itemViewOne)
        stackView.addArrangedSubview(itemViewTwo)
    }
    
    private func layoutUI(){
        view.addSubview(stackView)
        view.addSubview(actionButton)
       
            stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding : CGFloat = 20
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -padding),
           actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

}
