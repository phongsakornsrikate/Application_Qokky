//
//  MyRewardDetailViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 6/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import  Firebase

class MyRewardDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nameStore:UILabel!
       @IBOutlet weak var  rewardImageView:UIImageView!
       @IBOutlet weak var  useCoinLabel:UILabel!
       @IBOutlet weak var  rewardTitleLabel:UILabel!
       @IBOutlet weak var  rewardDetailTextView:UITextView!
       @IBOutlet weak var  rewardConditionLabel:UILabel!
       @IBOutlet weak var  rewardAnnotationLabel:UILabel!
       @IBOutlet weak var  codeLabel:UILabel!
       
    
    var rewardID = ""
    var storyBoardID_1 =  "" // level 1
    var storyBoardID_2 =  "" // level 2
    var storyBoardID_3 =  "" // level 3
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        readDataStore()
                     readDataCoupon()
    }
    

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return 1
           }
           
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "MyRewardDetailTableViewCell", for: indexPath) as! MyRewardDetailTableViewCell
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
      func readDataStore(){
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
           
            func readDataCoupon(){
                db.collection("Rewards").document("5HclHjrMnWB8oowhKqQa").addSnapshotListener { documentSnapshot, error in

                    guard let document = documentSnapshot else {
                        print("Error fetching document: \(error!)")
                        return
                    }
                    let data = document.data()

                    print("Current data: \(data)")

                      self.rewardTitleLabel.text = data?["RewardTitle"] as? String ?? ""
                      self.rewardDetailTextView.text = data?["RewardDetail"] as? String ?? ""
                      self.useCoinLabel.text = String(data?["UseCoin"] as? Int ?? 0)
                      self.codeLabel.text = String(data?["Code"] as? String ?? "")
                    
                     
                      
                      
                    if(data?["RewardImageUrl"] as? String != nil){
                                         let RewardImageUrl = data?["RewardImageUrl"] as? String
                                         self.rewardImageView.kf.setImage(with:URL(string: RewardImageUrl!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                                        
                                     }

                    self.tableView.reloadData()

                }

            }
      
    
    
    @IBAction func back(_ sender:Any){
        if(storyBoardID_3 == "CouponExchangeViewController"){
            let vc = storyboard?.instantiateViewController(withIdentifier: "RewardDetailViewController") as! RewardDetailViewController
                       vc.rewardID = rewardID
           
                    vc.storyBoardID_1 = "HomeViewController"
                    vc.storyBoardID_2 = "StoreMainViewController"
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
