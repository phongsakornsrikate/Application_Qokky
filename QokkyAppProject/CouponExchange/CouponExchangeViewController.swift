//
//  CouponExchangeViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 6/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import Firebase

class CouponExchangeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nameStore:UILabel!
    @IBOutlet weak var  rewardImageView:UIImageView!
    @IBOutlet weak var  useCoinLabel:UILabel!
    @IBOutlet weak var  rewardTitleLabel:UILabel!
    @IBOutlet weak var  rewardDetailTextView:UITextView!
    @IBOutlet weak var  rewardConditionLabel:UILabel!
    @IBOutlet weak var  rewardAnnotationLabel:UILabel!
    
   
    var rewardID = ""
    var storyBoardID_1 =  "" // level 1
    var storyBoardID_2 =  "" // level 2
    var storyBoardID_3 =  "" // level 3
   
    var timestamp:Double! //get time now
    override func viewDidLoad() {
        super.viewDidLoad()

          self.tableView.delegate = self
          self.tableView.dataSource = self
        
        if(rewardID != ""){
            readDataCoupon(self.rewardID)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                 return 1
             }
             
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let cell = tableView.dequeueReusableCell(withIdentifier: "CouponExchangeTableViewCell", for: indexPath) as! CouponExchangeTableViewCell
                 return cell
             }
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             return 700
         }

      /////// Hidden statusbar/////////////////////
      override var prefersStatusBarHidden: Bool{
                 return false
             }
    
    
    ///////// readDataStore
     let db = Firestore.firestore()
    func readDataStore(_ rewardID:String){
        db.collection("Store").document(rewardID).addSnapshotListener { documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let data = document.data()

            print("Current data: \(data)")

            self.nameStore.text = data?["Name"] as? String ?? "anonymous"
           
            self.tableView.reloadData()

        }

    }

    ///////// readDataCoupon
         
          func readDataCoupon(_ rewardID:String){
              db.collection("Rewards").document(rewardID).addSnapshotListener { documentSnapshot, error in

                  guard let document = documentSnapshot else {
                      print("Error fetching document: \(error!)")
                      return
                  }
                  let data = document.data()

                  print("Current data: \(data)")

                    self.rewardTitleLabel.text = data?["RewardTitle"] as? String ?? ""
                    self.rewardDetailTextView.text = data?["RewardDetail"] as? String ?? ""
                    self.useCoinLabel.text = String(data?["UseCoin"] as? Int ?? 0)
                   
                    
                    
                  if(data?["RewardImageUrl"] as? String != nil){
                                       let RewardImageUrl = data?["RewardImageUrl"] as? String
                                       self.rewardImageView.kf.setImage(with:URL(string: RewardImageUrl!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                                      
                                   }
                
                
                let StoreID = data?["StoreID"] as? String ?? ""
                         if(StoreID != ""){
                             self.readDataStore(StoreID)
                         }

                  self.tableView.reloadData()

              }

          }
    
    
    @IBAction func back(_ sender:Any){
        
            let vc = storyboard?.instantiateViewController(withIdentifier: "RewardDetailViewController") as! RewardDetailViewController
                       vc.rewardID = rewardID
           
                    vc.storyBoardID_1 = "HomeViewController"
                    vc.storyBoardID_2 = "StoreMainViewController"
            navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func exchangeRewardBtn(_ sender:Any){
        self.timestamp = Date().timeIntervalSince1970
             let lasstime = Date(timeIntervalSince1970: self.timestamp)
             let formatter =  DateFormatter()
             formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
             let createdAt = formatter.string(from: lasstime)
        let auth = Auth.auth().currentUser?.uid
              let database = Firestore.firestore()
              let myRewardID = generateRandomStirng()
        database.collection("Users").document(auth!).collection("myRewards").document(myRewardID).setData([
                        "MyRewardID":myRewardID,
                         "BuyAt":createdAt,
                         "RewardID":self.rewardID
                         
                   ])
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyRewardDetailViewController") as! MyRewardDetailViewController
        vc.rewardID = rewardID
       vc.storyBoardID_1 = "HomeViewController"
       vc.storyBoardID_2 = "StoreMainViewController"
       vc.storyBoardID_3 = "CouponExchangeViewController"
                          
        navigationController?.pushViewController(vc, animated: true)
    

}



////// generateRandomStirng

func generateRandomStirng() -> String {
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    let len = UInt32(letters.length)
    var randomString = ""
    for _ in 0 ..< 8 {
        let random = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(random))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    return randomString
}
}
