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

class CardBillViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource, AVCaptureMetadataOutputObjectsDelegate {

    @IBOutlet weak var catagoryCollectionView:UICollectionView!
    @IBOutlet weak var menuTableView:UITableView!
    @IBOutlet weak var nameStoreLabel:UILabel!
    @IBOutlet weak var tableNoLabel:UILabel!
    @IBOutlet weak var tableLabel:UILabel!
    @IBOutlet weak var nextLabel:UILabel!
    @IBOutlet weak var nextButton:UIButton!
    @IBOutlet weak var coinLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var bgBillImage:UIImageView!
    @IBOutlet weak var closeButton:UIButton!




    var QrCodeId:String = ""
     
    var video = AVCaptureVideoPreviewLayer()
    //Creating session
    let session = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.catagoryCollectionView.delegate = self
        self.catagoryCollectionView.dataSource = self
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        

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
            
        


            session.startRunning()
        
            readDataQrcode()
        
    }

//////////////  category CollectionView /////////////////////
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeFoodStoreClassArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryBillPageCollectionViewCell", for: indexPath) as! categoryBillPageCollectionViewCell
        let typeFoodStoreClass:typeFoodStoreClass
        typeFoodStoreClass = typeFoodStoreClassArr[indexPath.row]
        cell.categoryName.text = typeFoodStoreClass.typeName
        return cell
    }
  ////////////// Menu TableView /////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuTableViewCell", for: indexPath) as! menuTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }
    
    
    
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
                        let foodStoreID = data?["FoodStoreID"] as? String
                        self.readDataTypeFoodsStore(foodStoreID!)
                
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
                           self.catagoryCollectionView.reloadData()
                        self.readDataFoodsStore(FoodStoreID,"อาหาร")
                       }

                   
                   }
               }
    }
    
    
      /////// Query Detai food store /////////////////////////////////////////////////////////////////
      
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
                               let FoodName = doc.get("FoodName") as? String
                          //  let Data = typeFoodStoreClass(typeName:TypeName)
                          //  self.typeFoodStoreClassArr.insert(Data, at: 0) //sort Data มากไปน้อย
                               self.menuTableView.reloadData()
                            let alert = UIAlertController(title: "food", message: FoodName, preferredStyle: .alert)
                                 alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
                                                     alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
                                                         UIPasteboard.general.string = FoodName
    
                                                     }))
                            self.present(alert, animated: true, completion: nil)
                           }

                       
                       }
                   }
        }
    ///////Open Scan Qrcode page //////////////////////////////////////////////
    
    @IBAction func closeClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "QrScanViewController") as! QrScanViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
