//
//  GFAlertVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView           = GFAlertContainerAlert()
    let titleLable              = GFTitleLable(textAlignment: .center, fontSize: 20 )
    let messageLable            = GFBodyLable(textAlignment: .center)
    let actionBtn               = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var  alertTitle  : String?
    var  message : String?
    var  buttonTitle : String?
    
    
    init(alertTitle : String , message : String , buttonTitle : String){
        super.init(nibName : nil , bundle : nil)
        self.alertTitle         = alertTitle
        self.message            = message
        self.buttonTitle        = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        view.backgroundColor    = UIColor.black.withAlphaComponent(0.75)
        configuringContainerView()
        configureTitleView()
        configuringActionBtn()
        configureMessageLable()
    }
    
    
    func configuringContainerView()  {
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ,
            containerView .centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ,
            containerView.widthAnchor.constraint(equalToConstant: 280 )
            ,
            containerView.heightAnchor.constraint(equalToConstant: 220)
            
        ])
    }
    
    
    func configureTitleView()  {
        containerView.addSubview(titleLable)
        
        titleLable.text = alertTitle ?? "Somthing went Wrong"
        
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20) ,
            titleLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20) ,
            titleLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor  , constant: -20)
            ,
            titleLable.heightAnchor
                .constraint(equalToConstant: 28)
            
        ])
        
    }
    
    
    func configuringActionBtn(){
        containerView.addSubview(actionBtn)
        
        actionBtn.setTitle(buttonTitle ?? "OK", for: .normal )
        actionBtn.addTarget(self, action: #selector(dismissVC), for:   .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionBtn.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20) ,
            actionBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20) ,
            
            actionBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor  , constant: -20)
            ,
            actionBtn.heightAnchor
                .constraint(equalToConstant: 44)
            
        ])
        
    }
    
    
    func configureMessageLable()  {
        containerView.addSubview(messageLable)
        
        
        
        // set number of lines
        messageLable.text       = message ?? "unable to complete request "
        
        messageLable.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor
                , constant: 8) ,
            messageLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20) ,
            messageLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor  , constant: -20)
            ,
            messageLable.bottomAnchor
                .constraint(equalTo: actionBtn.topAnchor, constant: -12)
            
        ])
        
    }
    
    
    @objc func dismissVC (){
        // dimiss
        dismiss(animated: true)
        
    }
}
