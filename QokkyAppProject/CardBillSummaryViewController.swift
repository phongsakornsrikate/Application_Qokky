//
//  CardBillSummaryViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 19/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import AVFoundation

class CardBillSummaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,AVCaptureMetadataOutputObjectsDelegate  {

    @IBOutlet weak var billSummaryTableView:UITableView!
    @IBOutlet weak var nameStoreLabel:UILabel!
    @IBOutlet weak var tableNoLabel:UILabel!
    @IBOutlet weak var tableLabel:UILabel!
    @IBOutlet weak var nextLabel:UILabel!
    @IBOutlet weak var nextButton:UIButton!
    @IBOutlet weak var coinLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var bgBillImage:UIImageView!
    @IBOutlet weak var backButton:UIButton!
    @IBOutlet weak var bgAdjunctView:UIImageView!
    @IBOutlet weak var adjunctDetail:UITextView!
    @IBOutlet weak var addCoupon:UIButton!
    @IBOutlet weak var addCouponLabel:UILabel!
    @IBOutlet weak var bgAddCoupon:UIImageView!
    
      var video = AVCaptureVideoPreviewLayer()
      var timestamp:Double! //get time now
      //Creating session
      let session = AVCaptureSession()
      ///// back page //////////////////////
   
      
    
    var getQrCodeID = ""
    var getStoreID = ""
    var billID = ""
    var storeID = ""
      
    override func viewDidLoad() {
        super.viewDidLoad()

      self.billSummaryTableView.delegate = self
      self.billSummaryTableView.dataSource = self
        
        
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
                self.view.bringSubviewToFront(addCoupon)
                self.view.bringSubviewToFront(addCouponLabel)
                self.view.bringSubviewToFront(bgAddCoupon)
                self.view.bringSubviewToFront(nameStoreLabel)
                self.view.bringSubviewToFront(tableNoLabel)
                self.view.bringSubviewToFront(tableLabel)
                self.view.bringSubviewToFront(nextButton)
                self.view.bringSubviewToFront(nextLabel)
                self.view.bringSubviewToFront(backButton)
                self.view.bringSubviewToFront(coinLabel)
                self.view.bringSubviewToFront(priceLabel)
                self.view.bringSubviewToFront(bgAdjunctView)
                self.view.bringSubviewToFront(adjunctDetail)
                self.view.bringSubviewToFront(billSummaryTableView)
                session.startRunning()
            
    }
    

    //////////////Bill summary TableView /////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billSummaryTableViewCell", for: indexPath) as! billSummaryTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
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
    
    
    ///// Confirm order button //////////////////////
      @IBAction func confirmOrder(_ sender:Any){
          let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
          vc.QrCodeId = self.getQrCodeID
          vc.foodStoreID = self.getStoreID
          vc.billID = billID
          vc.storeID = storeID
          navigationController?.pushViewController(vc, animated: true)
      }
    

}
