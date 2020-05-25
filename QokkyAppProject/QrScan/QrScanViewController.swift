//
//  QrScanViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 13/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase


class QrScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var backBtn:UIButton!
    
  //  var StatusReceive = false
   // var StatusPay = false
    var cardBillViewController:CardBillViewController!
    //Creating session
    
    let session = AVCaptureSession()
    override func viewDidLoad() {
        super.viewDidLoad()
     
         
               
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
               
               output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
               
               output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
               
               video = AVCaptureVideoPreviewLayer(session: session)
               video.frame = view.layer.bounds
               view.layer.addSublayer(video)
              

               self.view.bringSubviewToFront(square)
               self.view.bringSubviewToFront(backBtn)

               session.startRunning()
           ///test
           
    }
    

    /////setUp Scanner QRCode
       func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
           if metadataObjects.count > 0{
               let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
               if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                  let stringURL = machineReadableCode.stringValue!
                   print("\n\\n\n\(stringURL)\n\n\n")
                   self.session.stopRunning()
                self.readDataQrcode(stringURL)
                   //self.checkDataQRCode(stringURL)
//                if(StatusReceive == true && StatusPay == true){
//                   let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
//                                  navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
//                   vc.QrCodeId = stringURL
//                   self.session.stopRunning()
//
//                }else if((StatusReceive == true && StatusPay == false) || (StatusReceive == false && StatusPay == false) || (StatusReceive == false && StatusPay == true) ){
//                    let vc = storyboard?.instantiateViewController(withIdentifier: "BillConfirmViewController") as! BillConfirmViewController
//                                                     navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
//                }
//
                
               }
           }
       }
    
    //// เช็คว่ามีบิลเก่าที่ยังทำรายการไม่เสร็จหรือเปล่า
    let db = Firestore.firestore()
    func readDataQrcode(_ QrCodeId:String){
              db.collection("QrCode").document(QrCodeId).addSnapshotListener { documentSnapshot, error in
                  
                  guard let document = documentSnapshot else {
                      print("Error fetching document: \(error!)")
                      return
                  }
                  let data = document.data()
                 
                  print("Current data: \(data)")
                 
            
               let storeID = data?["StoreID"] as? String

               print(storeID)
               if(data?["StoreID"] != nil && data?["StoreID"] as? String != ""){
                    self.QueryBillStore(storeID!,QrCodeId)
               }
              
               else{
                   print("Qrcode error")
               }
             
                
              }
              
          }
    
    
    
   
       
       func QueryBillStore(_ StoreID:String,_ QrcodeID:String) {
        let auth = Auth.auth().currentUser?.uid
           if(auth != nil){
                  let colRef = db.collection("Store").document(StoreID).collection("bills")
                        colRef.whereField("CustomerID", isEqualTo: auth!).getDocuments() { (querySnapshot, err) in
                                if err != nil {
                                    print("error")
                          
                      }
                            
                        
                      else {
                         
                       
                          for doc in querySnapshot!.documents {
                           print("\(doc.documentID) => \(doc.data())")
                           
                            let StatusReceive = doc.get("StatusReceive") as? Bool
                            let StatusPay = doc.get("StatusPay") as? Bool
                          ///  let CustomerID = doc.get("CustomerID") as! String
                          
                                
                               
                                    if(StatusReceive == true && StatusPay == true ){
                                        self.goToStore(QrcodeID,StoreID)
                                    }
                                    
                                    else if((StatusReceive == true && StatusPay == false) || (StatusReceive == false && StatusPay == false) || (StatusReceive == false && StatusPay == true)){
                                            self.goToBill()
                            }
                         
//                        let alert = UIAlertController(title: String(StatusReceive), message: String(StatusPay), preferredStyle: .alert)
//                                                                                                                                             alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                                                                                                                                                                 alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                                                                                                                                                                  UIPasteboard.general.string = String(StatusPay)
//
//                                                                                                                                                                 }))
//                                                                                                                                        self.present(alert, animated: true, completion: nil)
//
                          
                            

                                    }
                      }
                  }
       }
    }
    
    
    ////// Create temporary bill into Database  ///
    //// กรณีไม่มีบิลเก่า
    func goToStore(_ QrcodeID:String,_ storeID:String){
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
         vc.QrCodeId = QrcodeID
         vc.storeID = storeID
         vc.key = 1
        

        navigationController?.pushViewController(vc, animated: true)   ///// go to Store
//        self.session.stopRunning()
      
    }
    
    
     //// กรณีมีบิลเก่า
    func goToBill(){
          let vc = storyboard?.instantiateViewController(withIdentifier: "BillConfirmViewController") as! BillConfirmViewController
          navigationController?.pushViewController(vc, animated: true)   ///// go to Bill
//        self.session.stopRunning()
      }
    
    
    
    
    
    //// Create temporary bill into Database  ///
       
   
    
    
    

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }


    
    ///////Open Home  page //////////////////////////////////////////////
    
    @IBAction func backClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
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
