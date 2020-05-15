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
    
    
    
    var video = AVCaptureVideoPreviewLayer()
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
    }
    

    /////  tableView ///////////////

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if(tableView == maintableView){
           return 1
         }else{
            return 10
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == maintableView){
             let cell = tableView.dequeueReusableCell(withIdentifier: "foodDateilTableViewCell", for: indexPath) as! foodDateilTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "adjunctTableViewCell", for: indexPath) as! adjunctTableViewCell
            return cell
        }
       }

    
   
    
    
    
    ////// collectionView //////////////////////////
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return 5
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sizeCollectionViewCell", for: indexPath) as! sizeCollectionViewCell
      
            return cell
         
       
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
             return CGSize(width: 83, height: 88)
        
    }
    
    
    
    
    
    
    ///// back page //////////////////////
    @IBAction func backButtonPage(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
