//
//  UIViewControler+Extention.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit


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
}
