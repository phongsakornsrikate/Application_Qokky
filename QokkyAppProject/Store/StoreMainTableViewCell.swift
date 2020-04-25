//
//  StoreMainTableViewCell.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 2/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Kingfisher

class StoreMainTableViewCell: UITableViewCell {

    
     @IBOutlet weak var FrontImageCollectionView:UICollectionView!
     @IBOutlet weak var HotRewardStoreCollectionView:UICollectionView!
     @IBOutlet weak var  RewardStoreCollectionView:UICollectionView!
     @IBOutlet weak var nameStore:UILabel!
     @IBOutlet weak var captions:UILabel!
     @IBOutlet weak var  followers:UILabel!
     @IBOutlet weak var locationsDescriptions:UILabel!
     @IBOutlet weak var  logoImageView:UIImageView!
    
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.FrontImageCollectionView.delegate = self
        self.FrontImageCollectionView.dataSource = self
        self.HotRewardStoreCollectionView.delegate = self
        self.HotRewardStoreCollectionView.dataSource = self
        self.RewardStoreCollectionView.delegate = self
        self.RewardStoreCollectionView.dataSource = self
        
        logoImageView.layer.borderWidth = 1
        logoImageView.layer.masksToBounds = false
      //  logoImageView.layer.borderColor = UIColor.black.cgColor
        logoImageView.layer.cornerRadius = logoImageView.frame.height/2
        logoImageView.clipsToBounds = true
       // self.FrontImageCollectionView.reloadData()
        getCoverImageStore()
     
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    ///////////// get coverImageStore////////////////////////////////////////////////////////////////
    
    
     let db = Firestore.firestore()
    var  coverImageStoreArr = [coverImageStoreClass]()
       
       func getCoverImageStore() {
           let colRef = db.collection("Store").document("XBocZL7dFS4Y3ouJAQsS").collection("coverImageStore")
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
                       print(doc.get("coverImageUrl") as? String as Any)
                     let coverImageUrl = doc.get("coverImageUrl") as? String
                       let Data = coverImageStoreClass(coverImageUrl: coverImageUrl)
                       self.coverImageStoreArr.insert(Data, at: 0) //sort Data มากไปน้อย
                       self.FrontImageCollectionView.reloadData()
                   }

               
               }
           }
           }
       
  

}
    extension StoreMainTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
       
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == FrontImageCollectionView){
            print("12345")
            return self.coverImageStoreArr.count
        }else if(collectionView == HotRewardStoreCollectionView){
            return 4
        }else if(collectionView == RewardStoreCollectionView){
            return 4
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
                       return cell
                   }
           //        cell.coverImageView!.image = UIImage(named: "BG_login")
                   return cell
        }else if(collectionView == RewardStoreCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RewardStoreCollectionViewCell", for: indexPath) as! RewardStoreCollectionViewCell
                      return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotRewardStoreCollectionViewCell", for: indexPath) as! HotRewardStoreCollectionViewCell
                      return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView == FrontImageCollectionView){
            return CGSize(width: 375, height: 294)
        }else if(collectionView == HotRewardStoreCollectionView){
            return CGSize(width: 240, height: 143)
        }else if(collectionView == RewardStoreCollectionView){
            return CGSize(width: 335, height: 149)
        }
        else{
            return CGSize(width: 125, height: 54)
        }
    }
        
        
        
        
    
}
    


