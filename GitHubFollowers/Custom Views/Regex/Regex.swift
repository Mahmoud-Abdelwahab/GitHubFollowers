//
//  Regex.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import Foundation

extension String {
    
    var isValidEmail : Bool{                                // \\. for dot
        let emailFormate    = "[A-Z0-9a-z._%+-]+@[A-Za-z-0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate  = NSPredicate(format: "SELF MATCHES %@", emailFormate)
        
        return emailPredicate.evaluate(with: self)
    }
    
    
    var isValidPassword : Bool  {
        // Regex Restricts to 8 character minimum , 1 capital letter , 1 lowercase letter ,1 number               // * means at least one 
        let passwordFormate =   "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}"
        let passwordPredicate   = NSPredicate(format: "SELF MATCHES %@", passwordFormate)
        return passwordPredicate.evaluate(with: self)
    }
    
    
}
