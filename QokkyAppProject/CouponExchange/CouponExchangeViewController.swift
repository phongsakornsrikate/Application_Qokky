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
    @IBOutlet weak var  logoImageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

          self.tableView.delegate = self
          self.tableView.dataSource = self
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


    

}
