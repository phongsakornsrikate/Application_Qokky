//
//  StoreMainViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 2/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher


class StoreMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource  {

    
        @IBOutlet weak var maintableView:UITableView!
        @IBOutlet weak var FrontImageCollectionView:UICollectionView!
        @IBOutlet weak var HotRewardStoreCollectionView:UICollectionView!
        @IBOutlet weak var  RewardStoreCollectionView:UICollectionView!
        @IBOutlet weak var nameStore:UILabel!
        @IBOutlet weak var captions:UILabel!
        @IBOutlet weak var  followers:UILabel!
        @IBOutlet weak var locationsDescriptions:UILabel!
        @IBOutlet weak var  logoImageView:UIImageView!
        @IBOutlet weak var pageControl: UIPageControl!
       
    
    
   
    
   var storeID = "6k1aWpqnYyyIJD8Kjc0k"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.maintableView.delegate = self
        self.maintableView.dataSource = self
    
           self.FrontImageCollectionView.delegate = self
           self.FrontImageCollectionView.dataSource = self
           self.HotRewardStoreCollectionView.delegate = self
           self.HotRewardStoreCollectionView.dataSource = self
           self.RewardStoreCollectionView.delegate = self
           self.RewardStoreCollectionView.dataSource = self
    
        
        if(storeID != ""){
            readDataStore(storeID)
            getCoverImageStore(storeID)
            readSpecailReward(storeID)
            readNormalReward(storeID)
        }
        addRefreshController()
        
        
    }
    
    ////// table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       // print("Current data: \(self.coverImageStoreArr.count)")
          
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreMainTableViewCell", for: indexPath) as! StoreMainTableViewCell
        
//        cell.nameStore.text = self.name
//        cell.captions.text = self.captions
//        cell.locationsDescriptions.text = self.locationsDescriptions
//        cell.followers.text = self.followers
//        if(self.logoImageUrl != ""){
//        cell.logoImageView.kf.indicatorType = .activity
//        cell.logoImageView.kf.setImage(with:URL(string: self.logoImageUrl),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)


        
      //  }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 1234
      
    }
    
    /////// Hidden statusbar/////////////////////
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    
    
    ///////// collectionView
    
   
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
     
      if(collectionView == FrontImageCollectionView){
          print("12345")
        return coverImageStoreArr.count
      }else if(collectionView == HotRewardStoreCollectionView){
        return SpecialRewardClassArr.count
      }else if(collectionView == RewardStoreCollectionView){
          return NormalRewardClassArr.count
      }
      else{
          return 5
      }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if(collectionView == FrontImageCollectionView){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrontImageCollectionViewCell", for: indexPath) as! FrontImageCollectionViewCell
                 let coverImageStoreClass:coverImageStoreClass
                 coverImageStoreClass = coverImageStoreArr[indexPath.row]
                 if(coverImageStoreClass.coverImageUrl != nil){
                     cell.coverImageView.kf.setImage(with:URL(string: coverImageStoreClass.coverImageUrl!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
        }
                            return cell
                      
                //        cell.coverImageView!.image = UIImage(named: "BG_login")
    }
             else if(collectionView == RewardStoreCollectionView){
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardStoreCollectionViewCell", for: indexPath) as! RewardStoreCollectionViewCell
        let normalRewardClass:NormalRewardClass
                     normalRewardClass = NormalRewardClassArr[indexPath.row]
                cell.useCoinLabel.text = normalRewardClass.useCoin
        cell.rewardTitleLabel.text = normalRewardClass.rewardTitle
        cell.rewardDetailLabel.text = normalRewardClass.rewardDetail
            if(normalRewardClass.rewardImage != nil){
                cell.rewardImageView.kf.setImage(with:URL(string: normalRewardClass.rewardImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
            }
                           return cell
             }
             else{
                 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotRewardStoreCollectionViewCell", for: indexPath) as! HotRewardStoreCollectionViewCell
                 let specialRewardClass:SpecialRewardClass
                 specialRewardClass = SpecialRewardClassArr[indexPath.row]
            cell.useCoinLabel.text = specialRewardClass.useCoin
        if(specialRewardClass.rewardImage != nil){
            cell.rewardImageView.kf.setImage(with:URL(string: specialRewardClass.rewardImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
        }
                           return cell
                
             }
    
    
  }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let vc = storyboard?.instantiateViewController(withIdentifier: "RewardDetailViewController") as! RewardDetailViewController
            
        if(collectionView == HotRewardStoreCollectionView){
            let specialRewardClass:SpecialRewardClass
            specialRewardClass = SpecialRewardClassArr[indexPath.row]
            vc.rewardID = specialRewardClass.rewardID ?? ""
            vc.storyBoardID = "StoreMainViewController"
            navigationController?.pushViewController(vc, animated: true)
        }else if(collectionView == RewardStoreCollectionView){
            let normalRewardClass:NormalRewardClass
            normalRewardClass = NormalRewardClassArr[indexPath.row]
            vc.rewardID = normalRewardClass.rewardID ?? ""
            vc.storyBoardID = "StoreMainViewController"
            navigationController?.pushViewController(vc, animated: true)
        }
                 
    }
    
    
    /////// Query special reward //////////////////////////////////////////////////////////
       
     
        var  SpecialRewardClassArr = [SpecialRewardClass]()
    func readSpecailReward(_ StoreID:String) {

            let colRef = db.collection("Rewards")
            colRef.whereField("RewardStatus", isEqualTo: "special").whereField("StoreID", isEqualTo: StoreID).getDocuments() { (querySnapshot, err) in
                            if err != nil {
                                print("error")

                            }
                            else {

                              self.SpecialRewardClassArr.removeAll()
                                for doc in querySnapshot!.documents {
                                 print("\(doc.documentID) => \(doc.data())")
                                    
                                     let rewardID = doc.get("RewardID") as? String
                                     let rewardImage = doc.get("RewardImageUrl") as? String
                                     let useCoin = doc.get("UseCoin") as? Int ?? 0







                                   let Data = SpecialRewardClass(rewardID: rewardID, rewardImage: rewardImage, useCoin: String(useCoin))
                                  self.SpecialRewardClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                   self.HotRewardStoreCollectionView.reloadData()

                                }


                            }
                        }
             }
    
    
    
    
    /////// Query normall reward //////////////////////////////////////////////////////////
          
        
           var  NormalRewardClassArr = [NormalRewardClass]()
           func readNormalReward(_ StoreID:String) {

               let colRef = db.collection("Rewards")
               colRef.whereField("RewardStatus", isEqualTo: "special").whereField("StoreID", isEqualTo: StoreID).getDocuments() { (querySnapshot, err) in
                               if err != nil {
                                   print("error")

                               }
                               else {

                                 self.NormalRewardClassArr.removeAll()
                                   for doc in querySnapshot!.documents {
                                    print("\(doc.documentID) => \(doc.data())")
                                       
                                        let rewardID = doc.get("RewardID") as? String
                                        let rewardImage = doc.get("RewardImageUrl") as? String
                                        let rewardTitle = doc.get("RewardTitle") as? String
                                        let rewardDetail = doc.get("RewardDetail") as? String
                                        let useCoin = doc.get("UseCoin") as? Int ?? 0







                                    let Data = NormalRewardClass(rewardID: rewardID, rewardImage: rewardImage, useCoin: String(useCoin),rewardTitle: rewardTitle,rewardDetail: rewardDetail)
                                     self.NormalRewardClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                      self.RewardStoreCollectionView.reloadData()

                                   }


                               }
                           }
                }

       
   
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    ///////////// get coverImageStore////////////////////////////////////////////////////////////////
      
      
       let db = Firestore.firestore()
      var  coverImageStoreArr = [coverImageStoreClass]()
         
         func getCoverImageStore(_ StoreID:String) {
             let colRef = db.collection("Store").document(StoreID).collection("coverImage")
            // let query = colRef.whereField("coverImageUrl", isGreaterThan: "")
             colRef.getDocuments() { (querySnapshot, err) in
                 if err != nil {
                     print("error")
                     
                 }
                 else {
                    
                     self.coverImageStoreArr.removeAll()
                     for doc in querySnapshot!.documents {
                      print("\(doc.documentID) => \(doc.data())")
                      print("test")
                         print(doc.get("CoverImageUrl") as? String as Any)
                       let coverImageUrl = doc.get("CoverImageUrl") as? String
                         let Data = coverImageStoreClass(coverImageUrl: coverImageUrl)
                         self.coverImageStoreArr.insert(Data, at: 0) //sort Data มากไปน้อย
                         self.FrontImageCollectionView.reloadData()
                     }

                 
                }
                //////Page Control CollectionView//////
                self.pageControl.numberOfPages = self.coverImageStoreArr.count
                self.pageControl.currentPage = 0
                DispatchQueue.main.async {
                    self.timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
                }
             }
          
                      
             }
         
    
    
    ///Page Control CollectionView//////
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x/scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    
      var counter = 0
      var timer = Timer()
      @objc func changeImage(){
          if counter < coverImageStoreArr.count{
              let index = IndexPath.init(item: counter, section: 0)
              self.FrontImageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageControl.currentPage = counter+1
              counter += 1
          } else{
              counter = 0
              let index = IndexPath.init(item: counter, section: 0)
              self.FrontImageCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
              pageControl.currentPage = counter+1
              counter = 1
             
          }
      }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
   
    func readDataStore(_ StoreID:String){
        db.collection("Store").document(StoreID).addSnapshotListener { documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let data = document.data()

            print("Current data: \(data)")

            self.nameStore.text = data?["Name"] as? String ?? "anonymous"
            self.captions.text = data?["Captions"] as? String ?? ""
            self.followers.text = String(data?["CountFollowers"] as? Int ?? 0)
            self.locationsDescriptions.text = data?["LocationsDescriptions"] as? String ?? "-"
            
            
             if(data?["LogoImageUrl"] as? String != nil){
                let logoImage = data?["LogoImageUrl"] as? String
                self.logoImageView.kf.setImage(with:URL(string: logoImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width/2
                               self.logoImageView.clipsToBounds = true
            }
            self.maintableView.reloadData()

        }

    }


    
    ///// reload Data slide
     var refreshControl: UIRefreshControl?
      func addRefreshController(){
          refreshControl = UIRefreshControl()
          refreshControl?.tintColor = UIColor.black
          refreshControl?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
          self.maintableView.addSubview(refreshControl!)
      }
      
      @objc func refreshList(){
          refreshControl?.endRefreshing()
          maintableView.reloadData()
      }
   
}
