//
//  UIViewControler+Extention.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit
import SafariServices
fileprivate var containerView : UIView!   // fileprivate means anything in this file can use this variable [nothing can access it unless in this file ]
//this containerView is for bluring the screen behind the activity indicator
/// this extention to make every uiviewcontroler has default alert dialog

extension UIViewController {
    func presentGFAlertyOnMainThread(title : String , message :String , buttonTitle : String ){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve  // fade in
            self.present(alertVC,animated: true)
            
        }
    }
    
    /**********************************************/
    //*********** yuo can't create variable in the extention  ver cotainer : UIView! this will cause error so i will make it gloabal
    
    // activity Indicator
    
    func showLoadingView()  {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0 // this starting point for animating the view then i will increase it step by step
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8 }
        //animating from 0   to 0.8 alpha
        
        
        
        let  activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor) ,
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }
    
    
    
    
    func dismissLoadingView()  {
        // i will use it in a closure so i wanna put the code inside dispatch queue
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    
    //   loading wmpty view
    
    func showEmpltyStateView(with message : String , in view : UIView) {
        
        let emptyStateView = GFEmptyView(message: message) // u must iniialize this emptyView first
        emptyStateView.frame       =  view.bounds
        view.addSubview(emptyStateView)
        
    }
    
    
    /// present safari VC
    // safari VC now it open in the existing app it does't cose my app to open anther app( safari) but it's now incuded in our app u will botice that the tint color which we put to it green 
    func presentSafariVC (with url : URL ) {
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC , animated: true)
        
    }
    
}
