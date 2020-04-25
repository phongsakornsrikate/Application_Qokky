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


class StoreMainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {
    @IBOutlet weak var tableView:UITableView!
    
    
    /// Variables
    let db = Firestore.firestore()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        readDataStore()
    //    getCoverImageStore()
      //  print("Current data: \(self.coverImageStoreArr.count)")
      
    
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       // print("Current data: \(self.coverImageStoreArr.count)")
          
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoreMainTableViewCell", for: indexPath) as! StoreMainTableViewCell
        
        cell.nameStore.text = self.name
        cell.captions.text = self.captions
        cell.locationsDescriptions.text = self.locationsDescriptions
        cell.followers.text = self.followers
        if(self.logoImageUrl != ""){
        cell.logoImageView.kf.indicatorType = .activity
        cell.logoImageView.kf.setImage(with:URL(string: self.logoImageUrl),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)


        
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 2500
    }
    
    /////// Hidden statusbar/////////////////////
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    
    
    ///////// read data store//////////////////////
    
   
    
    var name:String = ""
    var captions:String = ""
    var followers:String = ""
    var logoImageUrl:String = ""
    var locationsDescriptions:String = ""
    
    func readDataStore(){
        db.collection("Store").document("XBocZL7dFS4Y3ouJAQsS").addSnapshotListener { documentSnapshot, error in
            
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let data = document.data()
           
            print("Current data: \(data)")
           
             self.name = data?["name"] as? String ?? "anonymous"
             self.captions = data?["captions"] as? String ?? ""
             self.followers = data?["followers"] as? String ?? "0"
             self.locationsDescriptions = data?["locationsDescriptions"] as? String ?? "-"
             self.logoImageUrl = data?["logoImageUrl"] as? String ?? ""
            print(self.name)
            self.tableView.reloadData()
          
        }
        
    }
    

    
//    var  coverImageStoreArr = [coverImageStoreClass]()
//
//    func getCoverImageStore() {
//        let colRef = db.collection("Store").document("XBocZL7dFS4Y3ouJAQsS").collection("coverImageStore")
//       // let query = colRef.whereField("coverImageUrl", isGreaterThan: "")
//        colRef.getDocuments() { (querySnapshot, err) in
//            if err != nil {
//                print("error")
//
//            }
//            else {
//                var n = 0
//                self.coverImageStoreArr.removeAll()
//                for doc in querySnapshot!.documents {
//                   // print("\(doc.documentID) => \(doc.data())")
//                 print("test")
//                    print(doc.get("coverImageUrl") as? String as Any)
//                  let coverImageUrl = doc.get("coverImageUrl") as? String
//                    let Data = coverImageStoreClass(coverImageUrl: coverImageUrl)
//                    self.coverImageStoreArr.insert(Data, at: 0) //sort Data มากไปน้อย
//                  // n = StoreMainViewController.n+1
//                    self.tableView.reloadData()
//                }
//
//
//            }
//        }
//        }
//
   
   
}
