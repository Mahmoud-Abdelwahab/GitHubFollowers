//
//  UITableView+Ext.swift
//  GitHubFollowers
//
//  Created by kasper on 6/28/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit
 

//******** * this extention for  removing the extra  empty cells if thetable view has to cell filled with data and appear to u we want to get rid of the extra empty cells
extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero) // this remove the extra empty cells
    }
    
    
    
    // reload data on main thread
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
