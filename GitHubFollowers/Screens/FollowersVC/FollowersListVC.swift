//
//  FollowersListVC.swift
//  GitHubFollowers
//
//  Created by kasper on 6/23/20.
//  Copyright © 2020 Mahmoud.kasper.GitHubFollowers. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
    var page                             = 1
    var hasMoreFolowers                  = true
    var followersList : [Follower]       = []
    var filterebFollowers : [Follower]   = []
    var isSearchActive                   = false
    var isLoadingMoreFollowers           = false
    enum Section{
        case main  // this cause we want one section
    }
    var userName : String?
    var collectionView : UICollectionView!
    //   UICollectionViewDiffableDataSource this required hashable protocole to be conformed  enum for section is hashable by default
    var dataSource : UICollectionViewDiffableDataSource<Section , Follower>!
    
    init(username : String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = username
        self.title    = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        //this is the storyboard inintializer
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControler()
        configureSearchControler()
        configureCollectionView()
        getFollowers(username: userName!, pagenNumber: page)
        configureDataSource()
        
        
    }
    
    @objc func addToFavourite() {
        print("favourite taped ")
        showLoadingView()
        isLoadingMoreFollowers = true
        // i need to create follower object for the current user i but i don't have except his user name i need his avatar url also so do netwrok call
        NetworkManager.shared.getUserInfo(for: userName!) { [weak self] (result) in
            guard let mySelf = self else{return}
            mySelf.dismissLoadingView()
            switch(result){
            case .success(let user ) :
                let followerOBJ = Follower(login:user.login, avatarUrl: user.avatarUrl)
                PersistenceManger.updateWith(favourtie: followerOBJ, actionType: PersistenceActionType.add) {[weak self] error in
                    guard let self = self else{return}
                    guard let error = error else{
                        ///********** if error is nill ---- wh have no error operation successded
                        self.presentGFAlertyOnMainThread(title: "Success", message: "You have successfully favourited this user 🎉", buttonTitle: "Hooray 🎉")
                        return
                    }
                    ///****** here the erro not nill then we have an error
                    self.presentGFAlertyOnMainThread(title: "Somthing went wrong", message: error.rawValue, buttonTitle: "OK 😵")
                }
                
            case .failure(let error) :
                mySelf.presentGFAlertyOnMainThread(title: "Somthing Went Wrong", message: error.rawValue, buttonTitle: "OK")
            }
            mySelf.isLoadingMoreFollowers = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func configureViewControler(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true // to make navigationbar title large
        
        //**  i wil creat my cutom barbutton item
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavourite))
        
        // now we want to add the done button to the navigationBar
        navigationItem.rightBarButtonItem = addButton
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
            //   #warning("Call Dismiss ")
            
            
            self.dismissLoadingView()
            
            switch result
            {
            case . success(let followers) :
                if followers.count < 100{ self.hasMoreFolowers = false} // self.hasMoreFolowers.toggle() this
                self.followersList.append(contentsOf: followers) // append it to keep all pages in the collectionview
                
                if self.followersList.isEmpty{
                    // if the appended array is emplty show my custom emptyview
                    let message = "This User Dos'nt have any Followers😮"
                    DispatchQueue.main.async {
                        self.showEmpltyStateView(with: message, in: self.view)
                        return
                    }
                }
                
                
                self.updataData(on: self.followersList)
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
    func updataData(on follower : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(follower)
        //the snapshot remain observing in the background thread so you if u want to access ui us despatch queue to become in the main thread
        // howeever in the WWDC vedio they called this is save to call from background thread but it  case warrninig sor to avoid it use
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)}
    }
    
    /**********************  Search Controler **************************/
    //************************************************************/
    
    func configureSearchControler() {
        
        let mySearchControler                                   = UISearchController()
        mySearchControler.searchResultsUpdater                  = self // ue need to conform this delegate  wihich is used for detecting any update in thr search feild
        mySearchControler.searchBar.placeholder                 = "Search By Name"
        navigationItem.searchController                         = mySearchControler // naviagtion item has a search controler and it's optional
        mySearchControler.searchBar.delegate                    = self /// for handeling cancel button
        
        mySearchControler.obscuresBackgroundDuringPresentation  = false
        // this for hidding the littel blureing which appear over the collectionView when u type somthing in the searchBar
        
        
    }
    
    
}


/************ Doing  Pagination */
extension FollowersListVC : UICollectionViewDelegate{
    
    // UICollectionViewDelegate handel any actions in the collection view
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // ** we need to know when did we reach the end of the scroll view
        let offsetY              = scrollView.contentOffset.y  // offsetY  this is how far u scrolled down
        let contentHeight        = scrollView.contentSize.height // the height of the entire scroll view  the big scrollview may be very large
        let screenHeight         = scrollView.frame.size.height //the height of the screen only
        
        print("offsetY        = \(contentHeight )")
        print("screenHeight   =  \(screenHeight )")
        
        if(offsetY > (contentHeight -  screenHeight))
        {
            
            guard hasMoreFolowers , !isLoadingMoreFollowers else { return} // has not folowers false page will not incremented and network call will not excuted here
            // this guard will prevent chow internet pagination bug 
            print(" *********************** Done ")
            print("offsetY            =       \(offsetY )")
            print("contentHeight      = \(contentHeight )")
            print("screenHeight       =  \(screenHeight )")
            page += 1
            getFollowers(username: userName!, pagenNumber: page )
            
            
        }
        
        ///*** ** ***** ** ** ** ** * * * * * ** * * ** * * ** * * ****//
        ///************************************************//
        /// the is a big bug here the case is : if u have very slow internet connection and u scroll down to load more pages and scrolled another time bafore the first  request finished here is the problem so we need to prevent  user to make another call if  the data i still loading so i will make bool bar isLoadingMoreFollowers to check this case
    }
    
    
    ///******************* did selecte row  *************************//
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearchActive ? filterebFollowers : followersList
        let userInfoVC = UserInfoVC()
        userInfoVC.userName = activeArray[indexPath.row].login
        userInfoVC.delegate = self 
        
        //    self.present(userInfoVC, animated: true) print(activeArray[indexPath.row].login)
        // recomended by appel to put done or cancel button in the modal which u prisent so i will crest nav controler to put buttons over it and presnt it
        let navigationBar = UINavigationController(rootViewController: userInfoVC)
        // so here insted of presnsting the userInfoVc i made my custom navcontroler and presnt it  and in userinfoVc i will add my cutom buttons over it
        present(navigationBar, animated: true)
    }
    
}



////********************* search controler delegate    **********************/
// UISearchBarDelegate  to handel cancel button in the search bar
extension FollowersListVC : UISearchResultsUpdating , UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let filter = searchController.searchBar.text , !filter.isEmpty  else {
            // this code handle a bug when u delelte  character by character from the search bar unti it becomes empty the displayed array will be the filltered so u will find bug when u click in some of the user cards
            filterebFollowers.removeAll()
            updataData(on: followersList)
            isSearchActive  = false
            return
            
        }
        isSearchActive  = true
        filterebFollowers = followersList.filter{$0.login!.lowercased().contains(filter.lowercased())}
        // this called map reduce
        //$0 this is the follower object in every loop in the array
        updataData(on: filterebFollowers)
    }
    
    //
    
    //    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //        isSearchActive = false
    //        updataData(on: followersList)
    //
    //    }
    
}


//  conforming protocol getFollowers

extension FollowersListVC : UserInfoVCDelegate {
    
    func didRequestFollowers(for username: String) {
        self.userName = username
        title         = userName
        page          = 1
        followersList.removeAll()
        filterebFollowers.removeAll()
        //collectionView.setContentOffset(.zero, animated: true)// this make collection view scroll to the top quickly  [if the collectionView scrolled to the botton then u go to userInfo so when u return back to show followers u need to scrol to the top quickly ]
        
        /**   but this   collectionView.setContentOffset(.zero, animated: true) move it the zero but we want to show searchBar also so we will scrol not just move to the row zero  and there is function lkie it in th tableview insted of item  ---> row  */
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),at:.top,animated:  true)
        
        
        getFollowers(username: username, pagenNumber: page)
    }
    
    
}
