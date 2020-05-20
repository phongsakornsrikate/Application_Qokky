//
//  FoodDetatilViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 14/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import AVFoundation

class FoodDetatilViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    

    @IBOutlet weak var maintableView:UITableView!
    @IBOutlet weak var adjuncttableView:UITableView!
    @IBOutlet weak var sizeCollectionView:UICollectionView!
    @IBOutlet weak var storeName:UILabel!
    @IBOutlet weak var tableNo:UILabel!
    @IBOutlet weak var tableLabel:UILabel!
    @IBOutlet weak var foodImage:UIImageView!
    @IBOutlet weak var foodName:UILabel!
    @IBOutlet weak var foodPrice:UILabel!
    @IBOutlet weak var foodCoin:UILabel!
    @IBOutlet weak var sumPrice:UILabel!
    @IBOutlet weak var sumCoin:UILabel!
    @IBOutlet weak var bgButton:UIButton!
    @IBOutlet weak var addLabel:UILabel!
    @IBOutlet weak var bgView:UIImageView!
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var sizeLabel:UILabel!

    var getStoreID  = ""
    var getfoodID = ""
    var getfoodImage = ""
    var getfoodName = ""
    var getfoodCoin = ""
    var getfoodPrice = ""
    var getStoreName = ""
    var getTableNo = ""
   
    
    var video = AVCaptureVideoPreviewLayer()
    //Creating session
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         
        // Define capture devcie
//                   let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
//
//
//                   do
//                   {
//                       let input = try AVCaptureDeviceInput(device: captureDevice!)
//                       session.addInput(input)
//                   }
//                   catch
//                   {
//                       print ("ERROR")
//                   }
//
//                   let output = AVCaptureMetadataOutput()
//                   session.addOutput(output)



                   video = AVCaptureVideoPreviewLayer(session: session)
                   video.frame = view.layer.bounds
                   view.layer.addSublayer(video)
                   self.view.bringSubviewToFront(bgView)
                   self.view.bringSubviewToFront(maintableView)
                   self.view.bringSubviewToFront(storeName)
                   self.view.bringSubviewToFront(tableNo)
                   self.view.bringSubviewToFront(storeName)
                   self.view.bringSubviewToFront(tableLabel)
                   self.view.bringSubviewToFront(sumCoin)
                   self.view.bringSubviewToFront(sumPrice)
                   self.view.bringSubviewToFront(bgButton)
                   self.view.bringSubviewToFront(addLabel)
                   self.view.bringSubviewToFront(backButton)
        
              //   session.startRunning()
                  maintableView.delegate = self
                  maintableView.dataSource = self
                    adjuncttableView.delegate = self
                        adjuncttableView.dataSource = self
                  sizeCollectionView.delegate = self
                  sizeCollectionView.dataSource = self
        
                    setDataStore()
      
            readDataSizeFood("TeHHUY1QBmv61Q0ftw4Q","OuKAxQDZDIzAHWKRnU0O")
        
    }
    
    
    ////// set data Store //////////////////////////////
    
    ////  show size food
    func setDataStore(){
        self.storeName.text = getStoreName
        self.tableNo.text = getTableNo
        self.foodName.text = getfoodName
        self.foodCoin.text = "ได้รับ \(getfoodCoin) เหรียญ"
        self.foodPrice.text = getfoodPrice
        if(getfoodImage != ""){
            foodImage.kf.setImage(with:URL(string: getfoodImage),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
        }
    }
    
    let db = Firestore.firestore()
    var  sizeClassArr = [sizeDetailClass]()
       func readDataSizeFood(_ FoodStoreID:String,_ FoodID:String) {
        let colRef = db.collection("Foods").document(FoodStoreID).collection("FoodsID").document(FoodID).collection("size")
                       colRef.getDocuments() { (querySnapshot, err) in
                           if err != nil {
                               print("error")

                           }
                           else {

                             self.sizeClassArr.removeAll()
                               for doc in querySnapshot!.documents {
                                print("\(doc.documentID) => \(doc.data())")
                                   
                                  
                                    let sizeDetail = doc.get("SizeDetail") as? String
                                  
                                    let sizePrice = doc.get("SizePrice") as? Int




//                                let alert = UIAlertController(title: "food", message: String(sizePrice!), preferredStyle: .alert)
//                                                                                                              alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                                                                                                  alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                                                                                   UIPasteboard.general.string = String(sizePrice!)
//
//                                                                                                                                  }))
//                                                                                                         self.present(alert, animated: true, completion: nil)

                                
                                let Data = sizeDetailClass(sizeDatail: sizeDetail, sizePrice: String(sizePrice!))
                                 self.sizeClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                  self.sizeCollectionView.reloadData()

                               }


                           }
                       }
            }

    
    ///// show adjunct food
    
    
      var  adjunctClassArr = [adjunctDetailClass]()
           func readDataAdjunctFood(_ FoodStoreID:String,_ FoodID:String) {
            let colRef = db.collection("Foods").document(FoodStoreID).collection("FoodsID").document(FoodID).collection("adjunct")
                           colRef.getDocuments() { (querySnapshot, err) in
                               if err != nil {
                                   print("error")

                               }
                               else {

                                 self.adjunctClassArr.removeAll()
                                   for doc in querySnapshot!.documents {
                                    print("\(doc.documentID) => \(doc.data())")
                                       
                                      
                                        let adjunctDetail = doc.get("AdjunctDetail") as? String
                                      
                                        let adjunctPrice = doc.get("AdjunctPrice") as? Int




    //                                let alert = UIAlertController(title: "food", message: String(sizePrice!), preferredStyle: .alert)
    //                                                                                                              alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
    //                                                                                                                                  alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
    //                                                                                                                                   UIPasteboard.general.string = String(sizePrice!)
    //
    //                                                                                                                                  }))
    //                                                                                                         self.present(alert, animated: true, completion: nil)

                                    
                                    let Data = adjunctDetailClass(adjunctDatail: adjunctDetail, adjunctPrice: String(adjunctPrice!))
                                     self.adjunctClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                      self.sizeCollectionView.reloadData()

                                   }


                               }
                           }
                }
    
    
    
    
    
    
    
    /////  tableView ///////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(tableView == maintableView){
           return 1
         }else if(tableView == adjuncttableView){
            return adjunctClassArr.count
         }else{
            return 10
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == maintableView){
             let cell = tableView.dequeueReusableCell(withIdentifier: "foodDateilTableViewCell", for: indexPath) as! foodDateilTableViewCell
            return cell
        }else if(tableView == adjuncttableView){
              let cell = tableView.dequeueReusableCell(withIdentifier: "foodDateilTableViewCell", for: indexPath) as! foodDateilTableViewCell
           return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "adjunctTableViewCell", for: indexPath) as! adjunctTableViewCell
            return cell
        }
       }

//    override func updateViewConstraints() {
//        tableHeightConstraint.constant = adjuncttableView.contentSize.height
//        super.updateViewConstraints()
//
//    }
//
//
    
    
    ////// collectionView //////////////////////////
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == sizeCollectionView){
        return sizeClassArr.count
        }else{
            return 10
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeCollectionViewCell", for: indexPath) as! sizeCollectionViewCell
        
      let sizeDetailClass:sizeDetailClass
      sizeDetailClass = sizeClassArr[indexPath.row]
        cell.sizeDetailLabel.text = sizeDetailClass.sizeDatail
        cell.sizePriceLabel.text = sizeDetailClass.sizePrice
            return cell
         
       
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
             return CGSize(width: 83, height: 88)
        
    }
    
    
    
    
    
    
    ///// back page //////////////////////
    @IBAction func backButtonPage(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
        vc.QrCodeId = self.getStoreID
        navigationController?.pushViewController(vc, animated: true)
    }
}