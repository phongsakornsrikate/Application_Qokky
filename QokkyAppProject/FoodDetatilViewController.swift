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
    @IBOutlet weak var foodMenuCount:UILabel!

    var getQrCodeID = ""
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
                   let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)


                   do
                   {
                       let input = try AVCaptureDeviceInput(device: captureDevice!)
                       session.addInput(input)
                   }
                   catch
                   {
                       print ("ERROR")
                   }

                   let output = AVCaptureMetadataOutput()
                   session.addOutput(output)



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
        
                session.startRunning()
                  maintableView.delegate = self
                  maintableView.dataSource = self
                    adjuncttableView.delegate = self
                        adjuncttableView.dataSource = self
                  sizeCollectionView.delegate = self
                  sizeCollectionView.dataSource = self
        
                    setDataStore()
        
        let alert = UIAlertController(title: self.getStoreID, message: self.getfoodID, preferredStyle: .alert)
                                                                                                                      alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                                                                                                                                          alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                                                                                                                                           UIPasteboard.general.string = self.getStoreID
        
                                                                                                                                          }))
                                                                                                                 self.present(alert, animated: true, completion: nil)
        if(self.getStoreID != "" && self.getfoodID != ""){
            readDataSizeFood(self.getStoreID,self.getfoodID)
            readDataAdjunctFood(self.getStoreID,self.getfoodID)
        }
        
        
     addRefreshController()
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




//                                let alert = UIAlertController(title: sizeDetail, message: String(sizePrice!), preferredStyle: .alert)
//                                                                                                              alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                                                                                                  alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                                                                                   UIPasteboard.general.string = String(sizePrice!)
//
//                                                                                                                                  }))
//                                                                                                         self.present(alert, animated: true, completion: nil)

                                if(sizePrice != nil){
                                let Data = sizeDetailClass(sizeDatail: sizeDetail, sizePrice: String(sizePrice!))
                                 self.sizeClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                  self.sizeCollectionView.reloadData()
                                }

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



//
//                                    let alert = UIAlertController(title: String(adjunctPrice!), message: adjunctDetail, preferredStyle: .alert)
//                                                                                                                  alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                                                                                                      alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                                                                                       UIPasteboard.general.string = String(adjunctPrice!)
//
//                                                                                                                                      }))
//                                                                                                             self.present(alert, animated: true, completion: nil)
////
//
                                    if(adjunctPrice != nil){
                                    let Data = adjunctDetailClass(adjunctDatail: adjunctDetail, adjunctPrice: String(adjunctPrice!))
                                     self.adjunctClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                      self.adjuncttableView.reloadData()
                                    }

                                   }


                               }
                           }
                }
    
    
    
    
    
    ////// add food Order menu ///////////////////////////////////
    
    
    @IBAction func addFoodMenu(_ sender:Any){
       
            let Count = Int(foodMenuCount.text!)
            if(Count! >= 0 && Count! < 9){
                foodMenuCount.text = "0\(String(Count! + 1))"

            }else if(Count! >= 9){
                foodMenuCount.text = String(Count! + 1)
            }
           
        }
        
        @IBAction func deleteFoodMenu(_ sender:Any){
             let Count = Int(foodMenuCount.text!)
                if(Count! > 0 && Count! < 10){
                    foodMenuCount.text = "0\(String(Count! - 1))"

                }else if(Count! > 0){
                    foodMenuCount.text = String(Count! - 1)
                }
               
        }
    
    /////  tableView ///////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(tableView == adjuncttableView){
            return adjunctClassArr.count
         }else{
            return 1
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == adjuncttableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "adjunctTableViewCell", for: indexPath) as! adjunctTableViewCell
            let adjunctDetailClass:adjunctDetailClass
            adjunctDetailClass = adjunctClassArr[indexPath.row]
            cell.adjunctDetailLabel.text = adjunctDetailClass.adjunctDatail
            if(adjunctDetailClass.adjunctPrice != nil){
            cell.adjunctPriceLabel.text = "$\(adjunctDetailClass.adjunctPrice!)"
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "foodDateilTableViewCell", for: indexPath) as! foodDateilTableViewCell
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
            print(sizeClassArr.count)
        return sizeClassArr.count
        }else{
            return 10
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       print(sizeClassArr.count)
        
           
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeCollectionViewCell", for: indexPath) as! sizeCollectionViewCell
        
      let sizeDetailClass:sizeDetailClass
      sizeDetailClass = sizeClassArr[indexPath.row]
        cell.sizeDetailLabel.text = sizeDetailClass.sizeDatail
        if(sizeDetailClass.sizePrice != nil){
        cell.sizePriceLabel.text = "$\(sizeDetailClass.sizePrice!)"
        }
//
//        let alert = UIAlertController(title: sizeDetailClass.sizePrice, message: sizeDetailClass.sizeDatail, preferredStyle: .alert)
//                                                                                      alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                                                                          alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                                                           UIPasteboard.general.string = sizeDetailClass.sizeDatail
//
//                                                                                                          }))
//                                                                                 self.present(alert, animated: true, completion: nil)
            return cell
         
        
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
             return CGSize(width: 83, height: 88)
        
    }
    
    
    
    
    
    
    ///// back page //////////////////////
    @IBAction func backButtonPage(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
        vc.QrCodeId = self.getQrCodeID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    ///add menu in bill///////////////////////////////
    
    @IBAction func addOrderToBill(_ sender:Any){
       
       }
}
