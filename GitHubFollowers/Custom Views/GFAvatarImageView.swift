//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by kasper on 6/25/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    let cache = NetworkManager.shared.cache
    let placeHolderImage =  #imageLiteral(resourceName: "gitHubLogo")
    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func configure(){
        layer.cornerRadius      = 10
        clipsToBounds           = true
        image                   = placeHolderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
     func downloadImage(from urlString : String){
        // to caching the image we need to add it to caching in the first time only
        // then in the secode time this func excuted we will never make the network call again so watch me hahah
        
        
        let cachKey = NSString(string: urlString) // the key in cache.object(forKey: cachKey)  is from type NSString so u need to converte string url to NSString
        if  let image = cache.object(forKey: cachKey){
            //we check if image is cached before so we will not make the network call agian
            self.image = image
            return // this is important here
            
        }
        // here the image is not cached this is the first time we download it
        
        guard let url = URL(string : urlString)  else { return }
        
        let task =  URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else {return}
            if error != nil {return}
            guard let response = response as? HTTPURLResponse , response.statusCode == 200  else {return}
            guard let data = data else {return}
            guard let image = UIImage(data: data) else {return}
            // here after downloading the image we need to add it to cach to check on it in the second time
            self.cache.setObject(image, forKey: cachKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
        task.resume()
    }
    
}
