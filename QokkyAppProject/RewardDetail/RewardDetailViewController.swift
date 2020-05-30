//
//  RewardDetailViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 4/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import Firebase

class RewardDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource  {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var ImageRewardDetailRecommendCollectionView:UICollectionView!
    @IBOutlet weak var nameStore:UILabel!
    @IBOutlet weak var  logoImageView:UIImageView!
    @IBOutlet weak var  rewardImageView:UIImageView!
    @IBOutlet weak var  useCoinLabel:UILabel!
    @IBOutlet weak var  rewardTitleLabel:UILabel!
    @IBOutlet weak var  rewardDetailLabel:UITextView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.tableView.delegate = self
         self.tableView.dataSource = self
         self.ImageRewardDetailRecommendCollectionView.delegate = self
         self.ImageRewardDetailRecommendCollectionView.dataSource = self
        
        
        readDataStore()
        readDataCoupon()
        readRecommendReward()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                    return 1
                }
                
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "RewardDetailTableViewCell", for: indexPath) as! RewardDetailTableViewCell
              return cell
          }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 1000
            }

         /////// Hidden statusbar/////////////////////
         override var prefersStatusBarHidden: Bool{
                    return false
                }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return rewardRecommendClassArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageRewardDetailRecommendCollectionViewCell", for: indexPath) as! ImageRewardDetailRecommendCollectionViewCell
            let rewardRecommendClass:rewardRecommendClass
                       rewardRecommendClass = rewardRecommendClassArr[indexPath.row]
        
              if(rewardRecommendClass.rewardImage != nil){
                  cell.rewardRecommendImageView.kf.setImage(with:URL(string: rewardRecommendClass.rewardImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
              }
                       return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            return CGSize(width: 174, height: 125)
        
    }
    
    
    
    
    
    
    ///////// readDataStore
     let db = Firestore.firestore()
    func readDataStore(){
        db.collection("Store").document("6k1aWpqnYyyIJD8Kjc0k").addSnapshotListener { documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let data = document.data()

            print("Current data: \(data)")

            self.nameStore.text = data?["Name"] as? String ?? "anonymous"
           
            
            
             if(data?["LogoImageUrl"] as? String != nil){
                let logoImage = data?["LogoImageUrl"] as? String
                self.logoImageView.kf.setImage(with:URL(string: logoImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                self.logoImageView.layer.cornerRadius = self.logoImageView.frame.size.width/2
                               self.logoImageView.clipsToBounds = true
            }
            self.tableView.reloadData()

        }

    }
    
    
    ///////// readDataCoupon
      
       func readDataCoupon(){
           db.collection("Rewards").document("5HclHjrMnWB8oowhKqQa").addSnapshotListener { documentSnapshot, error in

               guard let document = documentSnapshot else {
                   print("Error fetching document: \(error!)")
                   return
               }
               let data = document.data()

               print("Current data: \(data)")

               self.rewardTitleLabel.text = data?["RewardTitle"] as? String ?? ""
               self.rewardDetailLabel.text = data?["RewardDetail"] as? String ?? ""
               self.useCoinLabel.text = String(data?["UseCoin"] as? Int ?? 0)
              
               
               
                if(data?["RewardImageUrl"] as? String != nil){
                   let RewardImageUrl = data?["RewardImageUrl"] as? String
                   self.rewardImageView.kf.setImage(with:URL(string: RewardImageUrl!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                  
               }
               self.tableView.reloadData()

           }

       }
    
    
    
    
    
    /////// Query special reward //////////////////////////////////////////////////////////
          
        
           var  rewardRecommendClassArr = [rewardRecommendClass]()
           func readRecommendReward() {

               let colRef = db.collection("Rewards")
               colRef.whereField("RewardStatus", isEqualTo: "special").whereField("StoreID", isEqualTo: "6k1aWpqnYyyIJD8Kjc0k").getDocuments() { (querySnapshot, err) in
                               if err != nil {
                                   print("error")

                               }
                               else {

                                 self.rewardRecommendClassArr.removeAll()
                                   for doc in querySnapshot!.documents {
                                    print("\(doc.documentID) => \(doc.data())")
                                       
                                        let rewardID = doc.get("RewardID") as? String
                                        let rewardImage = doc.get("RewardImageUrl") as? String
                                      







                                      let Data = rewardRecommendClass(rewardImage:rewardImage,rewardID:rewardID)
                                     self.rewardRecommendClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                    self.ImageRewardDetailRecommendCollectionView.reloadData()

                                   }


                               }
                           }
                }
       
       
       


}
