//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    
    var followersList : [Follower]=[]
    enum Section{
        case main  // this cause we want one section
    }
    var userName : String?
    var collectionView : UICollectionView!
             //   UICollectionViewDiffableDataSource this required hashable protocole to be conformed  enum for section is hashable by default
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControler()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func configureViewControler(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // to make navigationbar title large
    }
    
    func   getFollowers(){
        /***     this is th e old way */
        //        NetworkManager.shared.getFollowers(for: userName!, page: 1) { (followers, errorMessage) in
        //
        //            guard let followers = followers else {
        //                 /// to get the value in evey case like .invalidUserName use .rawValue
        //                self.presentGFAlertyOnMainThread(title: "Bad Stuff happened ", message: errorMessage!.rawValue, buttonTitle: "OK")
        //                 return
        //            }
        //
        //            print(followers)
        //            print( "the followers count \(followers.count)")
        //        }
        
        // this is the new way using Result in swift 5
        NetworkManager.shared.getFollowers(for: userName!, page: 1) { [weak self] (result) in
            // [unowned self] unowned force unwrabe self  but [weak self]  weak doe'snt unwrabe self
                     guard let self = self else{return}
            switch result
            {
            case . success(let followers) :  self.followersList = followers
            self.updataData()
 // print(followers)  ;  print( "the followers count \(followers.count)")
                
            case .failure(let error):self.presentGFAlertyOnMainThread(title: "Bad Stuff happened ", message: error.rawValue, buttonTitle: "OK")
            }
            
            
        }
    }
    
    func configureCollectionView()  {
        collectionView  = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        //UIHelper.createThreeColumnFlowLayout(in: view) this is my custom flowlayout
        // here there is no constarins cause the collection view will be full screen
        view.addSubview(collectionView)
        // u must initialize collection view first then add it if u didn't do this then the collction view will be nil
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier:FollowerCell.reuseID)
    }
    
    
    
    
  
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section ,Follower>(collectionView: collectionView, cellProvider: { (myCollectionView, myIndexPath, myFollower) -> UICollectionViewCell? in
            let  cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for:  myIndexPath) as! FollowerCell
            
            cell.set(follower: myFollower) // this fuctino is gonna set the username and imageAvatare
            return cell
        })
        
    }
    
    //******************** UpdateData *********************//
    //*****************************************************//
    // this function called every time we wanna take a snapshot like reloadData()
    func updataData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.followersList)
        //the snapshot remain observing in the background thread so you if u want to access ui us despatch queue to become in the main thread
        // howeever in the WWDC vedio they called this is save to call from background thread but it  case warrninig sor to avoid it use
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)}
    }
    
}
