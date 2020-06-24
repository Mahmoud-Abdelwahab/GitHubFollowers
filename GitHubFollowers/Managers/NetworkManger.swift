//
//  NetworkManger.swift
//  GitHubFollowers
//
//  Created by kasper on 6/24/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import Foundation
class NetworkManager {
    // singelton
     
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    private init(){}
    
    func  getFollowers(for userName : String , page : Int ,completed: @escaping (Result<[Follower] , GFError>) -> Void)  {
                                 ///users/:username/followers
        let endPoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        print(userName)
        
        print(endPoint)
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase //// this snakeCase to camelCase converter
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            }catch{
                completed(.failure(.invalidData))
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
