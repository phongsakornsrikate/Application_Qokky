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
    var getStoreID  = "" //  key store in collections foods
    var getfoodID = ""
    var getfoodImage = ""
    var getfoodName = ""
    var getfoodCoin = ""
    var getfoodPrice = ""
    var getStoreName = ""
    var getTableNo = ""
    
    var billID = ""
    var storeID = "" // key store in collections store
    
    var sizeID = ""
    var sizeIDIsSelected = ""
   
   
    var timestamp:Double! //get time now
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
        
//        let alert = UIAlertController(title: self.getStoreID, message: self.getfoodID, preferredStyle: .alert)
//                                                                                                                      alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                                                                                                          alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                                                                                           UIPasteboard.general.string = self.getStoreID
//
//                                                                                                                                          }))
//                                                                                                                 self.present(alert, animated: true, completion: nil)
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
                                
                                    
                                    self.sizeID = doc.get("SizeID") as? String ?? ""
                                  
                                    let sizePrice = doc.get("SizePrice") as? Int





                                if(sizePrice != nil){
                                    let Data = sizeDetailClass(sizeDatail: sizeDetail, sizePrice: String(sizePrice!),sizeID: self.sizeID)
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
            
//            let Count = Int(cell.adjunctCount.text ?? "0") ?? 0
//                   if(Count > 0){
//                                 cell = tableView.cellForRow(at: indexPath) as! adjunctTableViewCell
//                                    cell.bgImage.image = UIImage(named: "Group 386")
//                                  //  return adjunctCell
//                   //  return cell
//
//                    }else{
//                                  cell = tableView.cellForRow(at: indexPath) as! adjunctTableViewCell
//                                    cell.bgImage.image = UIImage(named: "Group 385")
//                                                    //  return adjunctCell
//                             }
//            
          
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

            return cell
         
        
    }
    
    
    var selectedIndexPath : IndexPath? //declare this
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeCollectionViewCell", for: indexPath) as! sizeCollectionViewCell
        
         let sizeDetailClass:sizeDetailClass
         sizeDetailClass = sizeClassArr[indexPath.row]
        self.sizeIDIsSelected = sizeDetailClass.sizeID!
     
        let cell = collectionView.cellForItem(at: indexPath) as! sizeCollectionViewCell
                // let test = cell.bgImage.restorationIdentifier!
       
                 cell.bgImage.image = UIImage(named: "Group 386")
       
        
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
             return CGSize(width: 83, height: 88)
        
    }
    
    
    
    
    
    
    ///// back page //////////////////////
    @IBAction func backButtonPage(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
        vc.QrCodeId = self.getQrCodeID
        vc.foodStoreID = self.getStoreID
        vc.billID = billID
        vc.storeID = storeID
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    ///add menu in bill///////////////////////////////
    
    @IBAction func addOrderToBill(_ sender:Any){
      
        self.timestamp = Date().timeIntervalSince1970
        let lasstime = Date(timeIntervalSince1970: self.timestamp)
        let formatter =  DateFormatter()
        formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
        let createdAt = formatter.string(from: lasstime)
        
        updateFoodOrderToBill(createdAt)
        



               
       }
    
    
    //// update bill
  
    func updateFoodOrderToBill(_ CreateAt:String){
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
        
        let database = Firestore.firestore()
        let foodOrdersID = generateRandomStirng()
        database.collection("Store").document(storeID).collection("bills").document(billID).collection("foodOrders").document(foodOrdersID).setData([
            "FoodOrderID": foodOrdersID,
            "FoodID": getfoodID,
            "CreateAt":CreateAt,
            "SizeID":self.sizeIDIsSelected
            
            
        
        
        
        
        ]){ Err in
            if let Error = Err{
                      let alert = UIAlertController(title: "Err", message: "Err", preferredStyle: .alert)
                                                                                                                                    alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                                                                                                                                                        alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                                                                                                                                                          UIPasteboard.general.string = "Err"

                                                                                                                                                        }))
                                                                                                                               self.present(alert, animated: true, completion: nil)
            }else{
                
                vc.QrCodeId = self.getQrCodeID
                vc.foodStoreID = self.getStoreID
                vc.billID = self.billID
                vc.storeID = self.storeID
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

        
        
        
        
    }
    
    
    
    
    ////// calculate food order ////////////////////////////////////////////////
    
    var sizePriceIsSelected = 0
    var adjunctPriceIsSelected = 0
    func calculateFoodOrder(){
        
    }
    
  
    func querySizePrice(){
        db.collection("Foods").document(getStoreID).collection("FoodsID").document(getfoodID).collection("size").document(sizeIDIsSelected).addSnapshotListener { documentSnapshot, error in
                     
                     guard let document = documentSnapshot else {
                         print("Error fetching document: \(error!)")
                         return
                     }
                     let data = document.data()
                    
                     print("Current data: \(data)")
                    
                     self.sizePriceIsSelected = data?["SizePrice"] as? Int ?? 0
               

                 
                 
                 
                
                   
                 }
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
