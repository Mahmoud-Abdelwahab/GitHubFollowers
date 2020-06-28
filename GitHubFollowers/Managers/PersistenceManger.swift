//
//  PersistenceManger.swift
//  GitHubFollowers
//
//  Created by kasper on 6/27/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

///****** this enum for detecting the action that u want  to do [ adding to user defaault or removingg from user default
enum PersistenceActionType {
    case add , remove
}


///  ************** this enum created to store , retrive  and update the NSUserDefault where we will save array of  [followers objects] ---> array of favourite   when i click the add button in the main screen i will ad the current user to user default

// user default can save primitive type easly without enddonding or decodeing but the nonpremitive types objetcs we need to encode and decode first

enum PersistenceManger { //*** here i used enum you can use structe as u like but
    // the main differece is [ you can initailize en empty struct , but you can't initialize empty enum so enum more safty than struct
    
    enum Keys{
        static let favouriteKey = "Favourite"
    }
    static private let defaults = UserDefaults.standard
    
    // retrive array of favourit --> followers
    
    static func retriveFavouries(completed : @escaping (Result<[Follower] , GFError>) -> Void ){
        
        guard  let favouritesData = defaults.object(forKey: Keys.favouriteKey) as? Data else {
            completed(.success([])) // this is th efirst time you retive but no favorite saved
            return
        }
        
        do{
            let decoder   = JSONDecoder()
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
            
        }catch{
            //here there is an error in decodeing the favourite
            completed(.failure(.unableToFavourite))
            
        }
        
        
    }
    
    
    ///******* saving Favourties in the user Default
    // when u want to save u must get all followers array from the user default and check if the user exists or not then add it to the array then save the array again
    // so this savingFavourite func need the retrived array of favouted user which saved in the user defaults  /** followers == favourtie  casue we use follower POJO
    
    static func savingFavourite(favourites : [Follower]) -> GFError? {
        
        
        do{
            let encoder = JSONEncoder()
            let encodedFavourite = try encoder.encode(favourites)
            defaults.set(encodedFavourite, forKey: Keys.favouriteKey)
            return nil
            
        }catch{
            return  .unableToFavourite
        }
        
    }
    
    ///*********** this function which take the  action type from the  top enum and compinf the retrive and save function together to compleete  the action
    
    
    static func updateWith( favourtie : Follower , actionType : PersistenceActionType , completion :@escaping (GFError?) -> Void){
        
        
        // first we need to check if favourite exists before or not retrive the whole array
        
        retriveFavouries { (result) in
            switch(result)
            {
            case .success(var favouriteArray) : // here is want to know the action type
            
                switch actionType {
                case .add:
                    // after adding i want to check if it exists before or not
                    guard  !favouriteArray.contains(favourtie) else {
                        completion(.alreadyInFavourite)
                        return
                    }
                    //the favourite not exists here now u can save  this user
                    // first add the new user to favouriteArray
                    favouriteArray.append(favourtie)
                    
                case .remove:
                    favouriteArray.removeAll { $0.login == favourtie.login }
                }
                // here after performing add or remove operations then u need to save it finally
                completion( savingFavourite(favourites: favouriteArray) )
                
            case .failure(let error) : completion(error)
            }
        }
        
    }
    
}
