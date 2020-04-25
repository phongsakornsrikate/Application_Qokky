//
//  CardBillViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 17/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import AVFoundation

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
        
        
    }

//////////////  category CollectionView /////////////////////
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryBillPageCollectionViewCell", for: indexPath) as! categoryBillPageCollectionViewCell
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
    
    
    
    
    ///////Open Scan Qrcode page //////////////////////////////////////////////
    
    @IBAction func closeClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "QrScanViewController") as! QrScanViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
