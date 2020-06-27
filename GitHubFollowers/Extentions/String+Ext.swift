//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit
/// ******************** This extention to convert data from this formate "2020-07-09T02:50:47Z"*******/
extension String {
    func convertToDate() -> Date? {
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat     = "yyyy-MM-dd'T'HH:mm:ssZ" // this format which i get from the server
        dateFormatter.locale         = Locale(identifier: "eg_US_POSIX")   //defined the localized formate for your countery you can use this greate site to search for ur local and formate https://nsdateformatter.com/
        dateFormatter.timeZone       = .current // to make sure that u r getting ur correct timezone
        
        
        return dateFormatter.date(from: self)
    }
    
    
    // this fuction compine the to extention methods string and date u can ignor date wxtention and all this methoud and put them in one function but his againest  apple SOLID Prenciples ]
    
    func convertToDisplayFormate() -> String{
        guard  let date = self.convertToDate()else {return "N/A"}
        return date.convertToMonthYearFormate()
    }
    
}

