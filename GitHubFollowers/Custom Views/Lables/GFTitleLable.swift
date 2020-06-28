//
//  GFTitleLable.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFTitleLable: UILabel {
    
    //    override init(frame: CGRect) {
    //        super.init(frame:frame)
    //         configure()
    //    }
    //
    //     init(textAlignment : NSTextAlignment , fontSize : CGFloat) {
    //        super.init(frame : .zero )
    //        self.textAlignment = textAlignment
    //        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    //        configure()
    //    }
    /*** the above code u call configure two times in the default and in the custome constructor   so if u put  the keyword convienants which mean conveniants iniitialiizer  this  [ make the custom constructor call the default constractor which callled also desigated constractor also]*/
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    
    convenience init(textAlignment : NSTextAlignment , fontSize : CGFloat) {
        self.init(frame : .zero ) // here self.init casue it call it'd default one not a super
        self.textAlignment          = textAlignment
        self.font                   = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        //configure()
    }
    
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail // this make text is execed line be like   helloMyNameis mah...
        translatesAutoresizingMaskIntoConstraints  = false
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
