//
//  CardBillViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 17/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import Kingfisher

class CardBillViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var catagoryCollectionView:UICollectionView!
    @IBOutlet weak var menuTableView:UITableView!
    @IBOutlet weak var menuCollectionView:UICollectionView!
    @IBOutlet weak var nameStoreLabel:UILabel!
    @IBOutlet weak var tableNoLabel:UILabel!
    @IBOutlet weak var tableLabel:UILabel!
    @IBOutlet weak var nextLabel:UILabel!
    @IBOutlet weak var nextButton:UIButton!
    @IBOutlet weak var coinLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var bgBillImage:UIImageView!
    @IBOutlet weak var closeButton:UIButton!
    
  
    
    


  
    var foodStoreID = ""
    var FoodID = ""
    var QrCodeId:String = ""
    
    
    var billID = ""
    var storeID = ""
    var key = 0
     
    var video = AVCaptureVideoPreviewLayer()
    var timestamp:Double! //get time now
    //Creating session
    let session = AVCaptureSession()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.catagoryCollectionView.delegate = self
        self.catagoryCollectionView.dataSource = self
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        self.menuCollectionView.delegate = self
        self.menuCollectionView.dataSource = self
        

            //Define capture devcie
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
            self.view.bringSubviewToFront(bgBillImage)
            self.view.bringSubviewToFront(menuTableView)
            self.view.bringSubviewToFront(catagoryCollectionView)
            self.view.bringSubviewToFront(nameStoreLabel)
            self.view.bringSubviewToFront(tableNoLabel)
            self.view.bringSubviewToFront(tableLabel)
            self.view.bringSubviewToFront(nextButton)
            self.view.bringSubviewToFront(nextLabel)
            self.view.bringSubviewToFront(closeButton)
            self.view.bringSubviewToFront(coinLabel)
            self.view.bringSubviewToFront(priceLabel)
            
        

        if(key == 1){
            createTemporaryBill()
        }

            session.startRunning()
        
            readDataQrcode()
           
    }
    
    
    //// create temporary bill
   
   
    func createTemporaryBill(){
         let database = Firestore.firestore()
         let auth = Auth.auth().currentUser?.uid
         billID = self.generateRandomStirng()
         self.timestamp = Date().timeIntervalSince1970
         let lasstime = Date(timeIntervalSince1970: self.timestamp)
         let formatter =  DateFormatter()
         formatter.dateFormat = "dd. MMM yyyy H:mm:ss"
         let createdAt = formatter.string(from: lasstime)
        
         database.collection("Store").document(storeID).collection("bills").document(billID).setData([
                              "BillID": billID,
                              "CustomerID": auth,
                              "OrderNo":"",
                              "QrCodeID":QrCodeId,
                              "CreateAt":createdAt
            
                             
                              
                          ])
    }
    
  
    
   
                    
   

//////////////  category CollectionView /////////////////////
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == catagoryCollectionView){
        return typeFoodStoreClassArr.count
        }else if(collectionView == menuCollectionView){
            return foodStoreClassArr.count
        }else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         if(collectionView == catagoryCollectionView){
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryBillPageCollectionViewCell", for: indexPath) as! categoryBillPageCollectionViewCell
        
                let typeFoodStoreClass:typeFoodStoreClass
                typeFoodStoreClass = typeFoodStoreClassArr[indexPath.row]
                cell.categoryName.text = typeFoodStoreClass.typeName
                return cell
         }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as! MenuCollectionViewCell
            let FoodStore:foodStoreClass
            FoodStore = foodStoreClassArr[indexPath.row]
            cell.foodNameLabel.text = FoodStore.foodName
            cell.foodPriceLabel.text = "\(FoodStore.foodPrice!) บาท"
            cell.foodCoinLabel.text = FoodStore.foodCoin
               if(FoodStore.foodImage != nil){
                cell.foodImage.kf.setImage(with:URL(string: FoodStore.foodImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
                    }
            
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == catagoryCollectionView){
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryBillPageCollectionViewCell", for: indexPath) as! categoryBillPageCollectionViewCell
        let typeFoodStoreClass:typeFoodStoreClass
        typeFoodStoreClass = typeFoodStoreClassArr[indexPath.row]
//        let alert = UIAlertController(title: cell.categoryName.text!, message: foodStoreID, preferredStyle: .alert)
//                                        alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                            alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                UIPasteboard.general.string = self.foodStoreID
//
//                                                            }))
//                                   self.present(alert, animated: true, completion: nil)
                                  
      
        cell.categoryName.text = typeFoodStoreClass.typeName
        self.readDataFoodsStore(self.foodStoreID,typeFoodStoreClass.typeName!)
        }
            
            
        else if(collectionView == menuCollectionView){
            let FoodStore:foodStoreClass
            FoodStore = foodStoreClassArr[indexPath.row]
            let vc = storyboard?.instantiateViewController(withIdentifier: "FoodDetatilViewController") as! FoodDetatilViewController
            vc.getfoodID = FoodStore.foodID ?? "null"
            vc.getStoreID = self.foodStoreID
            vc.getQrCodeID = self.QrCodeId
            vc.getStoreName = nameStoreLabel.text ?? "null"
            vc.getTableNo = tableNoLabel.text ?? "null"
            vc.getfoodImage = FoodStore.foodImage ?? "null"
            vc.getfoodName = FoodStore.foodName ?? "null"
            vc.getfoodCoin = FoodStore.foodCoin ?? "null"
            vc.getfoodPrice = FoodStore.foodPrice ?? "null"
            vc.billID = billID
            vc.storeID = storeID
            
      
            
            
              navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
        }
                             
        
        
    }
    
   
        
       
    
    
    
    
    
    
    
   
    
    
    
    
    
  ////////////// Menu TableView /////////////////////
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! menuTableViewCell
//        let foodStoreClass:foodStoreClass
//        foodStoreClass = foodStoreClassArr[indexPath.row]
//        cell.foodNameLabel.text = foodStoreClass.foodName
//        cell.foodPriceLabel.text = "$ \(foodStoreClass.foodPrice!)"
//        cell.foodCoinLabel.text = "ได้ \(foodStoreClass.foodCoin!) เหรียญ"
//
//
//               if(foodStoreClass.foodImage != nil){
//                cell.foodImage.kf.setImage(with:URL(string: foodStoreClass.foodImage!),placeholder: nil,options: [.transition(.fade(0.7))],progressBlock: nil)
//        }
//        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1000
    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if(section == 0){
//            return "Size: ปกติ"
//        }else{
//            return "Size: พิเศษ"
//        }
//    }
    
    
    
    /////// QueryQrCode store /////////////////////////////////////////////////////////////////
    let db = Firestore.firestore()
    //var QrCodeId:String
    func readDataQrcode(){
           db.collection("QrCode").document(QrCodeId).addSnapshotListener { documentSnapshot, error in
               
               guard let document = documentSnapshot else {
                   print("Error fetching document: \(error!)")
                   return
               }
               let data = document.data()
              
               print("Current data: \(data)")
              
            self.tableNoLabel.text = data?["TableNo"] as? String ?? "none"
            let storeID = data?["StoreID"] as? String

            print(storeID)
            if(data?["StoreID"] != nil && data?["StoreID"] as? String != ""){
                 self.readDataStore(storeID!)
            }
           
            else{
                print("Qrcode error")
            }
          
             
           }
           
       }
       
     /////// Query Detail store /////////////////////////////////////////////////////////////////
    func readDataStore(_ storeID:String){
              db.collection("Store").document(storeID).addSnapshotListener { documentSnapshot, error in
                  
                  guard let document = documentSnapshot else {
                      print("Error fetching document: \(error!)")
                      return
                  }
                  let data = document.data()
                 
                  print("Current data: \(data)")
                 
               
                
                if(data?["Name"] != nil && data?["Name"] as? String != ""){
                   self.nameStoreLabel.text = data?["Name"] as? String
                     
                    if(data?["FoodStoreID"] != nil && data?["FoodStoreID"] as? String != ""){
                        self.foodStoreID = (data?["FoodStoreID"] as? String)!
                        self.readDataTypeFoodsStore(self.foodStoreID)
                      
                       
                }
                
                }
                else{
                    self.nameStoreLabel.text = "anonymous"
                }
              }
              
          }
 
    /////// Query Detai type  food store /////////////////////////////////////////////////////////////////
  
    var  typeFoodStoreClassArr = [typeFoodStoreClass]()
           
    func readDataTypeFoodsStore(_ FoodStoreID:String) {
               let colRef = db.collection("Foods").document(FoodStoreID).collection("typefoods")
               colRef.getDocuments() { (querySnapshot, err) in
                   if err != nil {
                       print("error")
                       
                   }
                   else {
                      
                       self.typeFoodStoreClassArr.removeAll()
                       for doc in querySnapshot!.documents {
                        print("\(doc.documentID) => \(doc.data())")
                           let TypeName = doc.get("TypeName") as? String
                        let Data = typeFoodStoreClass(typeName:TypeName)
                        self.typeFoodStoreClassArr.insert(Data, at: 0) //sort Data มากไปน้อย
                               self.readDataFoodsStore(FoodStoreID,"อาหาร")
                           self.catagoryCollectionView.reloadData()
                     
                       
                       }

                   
                   }
               }
    }
    
    
    
    /////// Query food Menu //////////////////////////////////////////////////////////
    
   //   let dbRef = Firestore.firestore()
     var  foodStoreClassArr = [foodStoreClass]()
     func readDataFoodsStore(_ FoodStoreID:String,_ TypeName:String) {

              let colRef = db.collection("Foods").document(FoodStoreID).collection("FoodsID")
                     colRef.whereField("FoodType", isEqualTo: TypeName).getDocuments() { (querySnapshot, err) in
                         if err != nil {
                             print("error")

                         }
                         else {

                           self.foodStoreClassArr.removeAll()
                             for doc in querySnapshot!.documents {
                              print("\(doc.documentID) => \(doc.data())")
                                  self.FoodID = (doc.get("FoodID") as? String)!
                                  let FoodName = doc.get("FoodName") as? String
                                  let FoodImage = doc.get("FoodImage") as? String
                                  let FoodPrice = doc.get("FoodPrice") as? Int
                                  let FoodCoin = doc.get("GetCoin") as? Int







                                let Data = foodStoreClass(foodName: FoodName, foodPrice: String(FoodPrice!), foodImage: FoodImage,foodCoin: String(FoodCoin!),foodID: self.FoodID)
                               self.foodStoreClassArr.insert(Data, at: 0) //sort Data มากไปน้อย

                                self.menuCollectionView.reloadData()

                             }


                         }
                     }
          }

    
    
    
    
    ///////Open Scan Qrcode page //////////////////////////////////////////////
     /// close bill ////////////////////////////
    /// delete temporary bill
    
    @IBAction func closeClicked(_ sender:Any){
        let database = Firestore.firestore()
        let auth = Auth.auth().currentUser?.uid
        database.collection("Store").document(storeID).collection("bills").document(billID).delete()
        
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "QrScanViewController") as! QrScanViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    ///// Go to bill summary page //////////////////////
      @IBAction func nextButton(_ sender:Any){
          let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillSummaryViewController") as! CardBillSummaryViewController
          vc.getQrCodeID = self.QrCodeId
          vc.getStoreID = self.foodStoreID
          vc.billID = billID
          vc.storeID = storeID
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

