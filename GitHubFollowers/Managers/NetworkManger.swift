//
//  NetworkManger.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit
class NetworkManager {
    // singelton
    
    static let shared           = NetworkManager()
    private let baseURL          = "https://api.github.com/users/"
    
    let cache                   = NSCache<NSString , UIImage>() // this for catching the image
    
    private init(){}
    
    func  getFollowers(for userName : String , page : Int ,completed: @escaping (Result<[Follower] , GFError>) -> Void)  {
        ///users/:username/followers
        let endPoint            = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        //   print(userName)
        
        // print(endPoint)
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        // the url is valid
        
        // the native way to do network request
        let task = URLSession.shared.dataTask(with: url){data , response , error
            in
            
            if let _ = error{
                // there is an error
                completed(.failure(.unableToComplete))
            }
            
            
            // statusCode 200 mean everything is ok
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                
                completed(.failure(.invalidResponse) )
                return
            }
            
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            // here there is no error here and we recieved the ressponse
            
            
            do {      // decoder take data from the server and decode it in our object
                // encoder take our object and converting it to data
                let decoder                      = JSONDecoder()
                decoder.keyDecodingStrategy      = .convertFromSnakeCase //// this snakeCase to camelCase converter
                decoder.dateDecodingStrategy     = .iso8601 // this convert string date which comes from the server automatically in the date object
                let followers                    = try decoder.decode([Follower].self, from: data)
                
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    
    
    
    
    // //*************************  get Users ************************************
    ///***  @escaping means our closure can be called after a period of  time  and make this function  out live untile the  network call finishes  .... closures by default  nonEscaping  but if u make it  escaping u maut put [weal self] to avoid memery leaks
    func  getUserInfo(for userName : String ,completed: @escaping (Result<User , GFError>) -> Void)  {
        /* https://api.github.com/users/:userNameHere */
        let endPoint = baseURL + "\(userName)"
        //   print(userName)
        
        // print(endPoint)
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        // the url is valid
        
        // the native way to do network request
        let task = URLSession.shared.dataTask(with: url){data , response , error
            in
            
            if let _ = error{
                // there is an error
                completed(.failure(.unableToComplete))
            }
            
            
            // statusCode 200 mean everything is ok
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                
                completed(.failure(.invalidResponse) )
                return
            }
            
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            // here there is no error here and we recieved the ressponse
            
            
            do {      // decoder take data from the server and decode it in our object
                // encoder take our object and converting it to data
                let decoder                  = JSONDecoder()
                decoder.keyDecodingStrategy  = .convertFromSnakeCase //// this snakeCase to camelCase converter
                decoder.dateDecodingStrategy  = .iso8601 // this convert string date which comes from the server automatically in the date object
                let user                     = try decoder.decode(User.self, from: data)
                completed(.success(user))
            }catch{
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    ///** ******** * * ** * * * ** * Dowinload image from the internet
    
    func downloadImage(from urlString : String ,completed : @escaping (UIImage?)->Void){
        // to caching the image we need to add it to caching in the first time only
        // then in the secode time this func excuted we will never make the network call again so watch me hahah
        
        
        let cachKey = NSString(string: urlString) // the key in cache.object(forKey: cachKey)  is from type NSString so u need to converte string url to NSString
        if  let image = cache.object(forKey: cachKey){
            //we check if image is cached before so we will not make the network call agian
            completed(image)
            
            return // this is important here
            
        }
        // here the image is not cached this is the first time we download it
        
        guard let url = URL(string : urlString)  else {
            completed(nil)
            return
        }
        
        let task =  URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self ,
                error == nil ,
                let response = response as? HTTPURLResponse , response.statusCode == 200  ,
                let data = data ,
                let image = UIImage(data: data) else{
                    completed(nil)
                    return
            }
            // here after downloading the image we need to add it to cach to check on it in the second time
            self.cache.setObject(image, forKey: cachKey)
            
            DispatchQueue.main.async {
                completed(image)
            }
            
        }
        task.resume()
    }
    
}



///  this is the old way for response and error

//func  getFollowers(for userName : String , page : Int ,completed: @escaping ([Follower]? , ErrorMessage?) -> Void)  {
//                                ///users/:username/followers
//       let endPoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
//       print(userName)
//       
//       print(endPoint)
//       guard let url = URL(string: endPoint) else {
//           completed(nil , .invalidUserName)
//               return
//       }
//       // the url is valid
//       
//       // the native way to do network request
//       let task = URLSession.shared.dataTask(with: url){data , response , error
//           in
//           
//           if let _ = error{
//               // there is an error
//               completed(nil ,  .unableToComplete)
//           }
//           
//         
//              // statusCode 200 mean everything is ok
//           guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
//            
//               completed(nil , .invalidResponse)
//               return
//           }
//           
//            
//           guard let data = data else{
//               completed(nil , .invalidData)
//               return
//           }
//            // here there is no error here and we recieved the ressponse
//           
//           
//           do {      // decoder take data from the server and decode it in our object
//                // encoder take our object and converting it to data
//               let decoder = JSONDecoder()
//               decoder.keyDecodingStrategy = .convertFromSnakeCase //// this snakeCase to camelCase converter
//               let followers = try decoder.decode([Follower].self, from: data)
//                 completed(followers ,nil)
//           }catch{
//               completed(nil , .invalidData)
//           }
//           
//       }
//       task.resume()
//   }
//   
