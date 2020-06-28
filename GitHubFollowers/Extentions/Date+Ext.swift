//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import Foundation

// this extention take date formate  and convert it to humane redable style like 02 june, 2020

extension Date {
    func convertToMonthYearFormate() -> String {
        let dateFormattre = DateFormatter()
        dateFormattre.dateFormat = "MMMM dd, yyyy" // this formate which i want to show it MMM d, yyyy
        
        return dateFormattre.string(from: self)
    }
    
}

