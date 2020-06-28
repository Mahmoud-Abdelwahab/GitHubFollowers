//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by kasper on 6/25/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

enum UIHelper { // enum more safe than struct  because enum can't be initialized  and we don't want  to make somthing like tis let helper = UIHelper()
    
    static func createThreeColumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout{
        let width                     = view.bounds.width
        let padding : CGFloat         = 12
        let mininmumSpacing : CGFloat = 10
        let availableWidth            = width - (padding * 2) - (mininmumSpacing * 2)
        let itemWidth                 = availableWidth / 3
        let flowLayout                = UICollectionViewFlowLayout()
        flowLayout.sectionInset       = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize           = CGSize(width: itemWidth, height: itemWidth + 40) //+40 to give extra height for the lable
        
        return flowLayout
    }
}
