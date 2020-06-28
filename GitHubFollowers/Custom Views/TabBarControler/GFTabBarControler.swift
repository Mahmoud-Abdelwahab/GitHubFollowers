//
//  GFTabBarControler.swift
//  GitHubFollowers
//
//  Created by kasper on 6/28/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFTabBarControler: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor    = .systemGreen
        viewControllers                    = [CreatSearchNavigationControler() , CreatFavouriteNavigationControler()]
    }
    
    //  to be more clear i separt them u can put then in onne funtion and pass some 4 params to it
    func CreatSearchNavigationControler() -> UINavigationController {
        let searchVc = SearchVC()
        
        searchVc.title = "Search"
        
        searchVc.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVc)
        
    }
    
    func CreatFavouriteNavigationControler() -> UINavigationController {
        let favoriteVC = FavouriteList()
        
        favoriteVC.title = "Search"
        
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteVC)
        
    }
    
    //      /// crateTabBar
    //      func CreateTabBar() ->UITabBarController {
    //          let tabBar = UITabBarController()
    //          UITabBar.appearance().tintColor = .systemGreen
    //                tabBar.viewControllers = [CreatSearchNavigationControler() , CreatFavouriteNavigationControler()]
    //
    //
    //          return tabBar
    //      }
    
}
