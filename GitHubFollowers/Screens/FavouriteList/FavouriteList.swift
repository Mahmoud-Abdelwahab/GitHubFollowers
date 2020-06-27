//
//  FavouriteList.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FavouriteList: UIViewController {

    
    let tableView               = UITableView()
    
    var favorites : [Follower]   = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
      configureViewControler()
    
      configureTableView()
     
    }
    override func viewWillAppear(_ animated: Bool) {
          getFavorite()
    }
  
    func configureViewControler() {
        view.backgroundColor = .systemBackground // adapte itself with the light and dark mode
        title                = "Favorites"
        // to make it large title show the code below ⇣
        navigationController?.navigationBar.prefersLargeTitles = true
           
    }
    
    func getFavorite(){
          PersistenceManger.retriveFavouries {[weak self] (result) in
                        guard let self = self else {return}
                        
                        switch result {
                        case .success(let favouriteList ) :
                            //* we need to check if user don't have any favorite  then show him empty state
                            
                            if favouriteList.isEmpty {
                                self.showEmpltyStateView(with: "No Favorites?\n You can add one on the Follower screen ", in: self.view)
                            }else{  self.favorites = favouriteList
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    //** here in case it enter empty stats first which means the user has no followers so u show showEmpltyStateView ok now showEmpltyStateView is on the top of the table view --- tableView is not hidden under it  if the user favorite someone and come back to see the favorite list u need to return table view on the top again to see the tableview see the vcode below
                                    self.view.bringSubviewToFront(self.tableView)
                                }
                            }
                            
                          
                        case .failure(let error ) :
                            self.presentGFAlertyOnMainThread(title: "somthing went wrong ", message: error.rawValue, buttonTitle: "OK")
                        }
                        
                    }
      }
      
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.frame         = view.bounds // fill thw whole view
        tableView.rowHeight     = 80
        tableView.delegate      = self
        tableView.dataSource    = self
        /// *************** registering cell *****************//
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }

}


/////********************** TableView Exentions

extension FavouriteList : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
