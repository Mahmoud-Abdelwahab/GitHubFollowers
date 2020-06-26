//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    var page = 1
    var hasMoreFolowers = true
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
        getFollowers(username: userName!, pagenNumber: page)
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
    
    func   getFollowers(username : String , pagenNumber : Int){
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
        
        // calling shoe acitivity indicator
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName!, page:pagenNumber) { [weak self] (result) in
            // [unowned self] unowned force unwrabe self  but [weak self]  weak doe'snt unwrabe self
          
              guard let self = self else{return}
              #warning("Call Dismiss ")
            
            
              self.dismissLoadingView()
                   
            switch result
            {
            case . success(let followers) :
            if followers.count < 100{ self.hasMoreFolowers = false}
            self.followersList.append(contentsOf: followers) // append it to keep all pages in the collectionview
            
            if self.followersList.isEmpty{
                // if the appended array is emplty show my custom emptyview
                let message = "This User Dos'nt have any Followers😮"
                DispatchQueue.main.async {
                    self.showEmpltyStateView(with: message, in: self.view)
                    return
                }
            }
            
            
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
        
        collectionView.delegate = self
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


/************ Doing  Pagination */
extension FollowersListVC : UICollectionViewDelegate{
    
    // UICollectionViewDelegate handel any actions in the collection view
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
       // ** we need to know when did we reach the end of the scroll view
        let offsetY       = scrollView.contentOffset.y  // offsetY  this is how far u scrolled down
        let contentHeight = scrollView.contentSize.height // the height of the entire scroll view  the big scrollview may be very large
        let screenHeight        = scrollView.frame.size.height //the height of the screen only
        
        print("offsetY        =       \(offsetY )")
        print("contentHeight  = \(contentHeight )")
        print("screenHeight   =  \(screenHeight )")
        
        if(offsetY > (contentHeight -  screenHeight))
        {
          
           guard hasMoreFolowers else { return} // has not folowers false page will not incremented and network call will not excuted here
               print(" *********************** Done ")
                   print("offsetY        =       \(offsetY )")
                     print("contentHeight  = \(contentHeight )")
                     print("screenHeight   =  \(screenHeight )")
            page += 1
            getFollowers(username: userName!, pagenNumber: page )
      
            
        }
    }
    
   
}
