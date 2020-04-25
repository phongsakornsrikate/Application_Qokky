//
//  QrScanViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 13/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import AVFoundation


class QrScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    @IBOutlet weak var square: UIImageView!
    var video = AVCaptureVideoPreviewLayer()
    
    @IBOutlet weak var backBtn:UIButton!
    
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
           
           
    }
    

//     func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)  {
//            print("succeed1")
//           if metadataObjects != nil && metadataObjects.count != 0
//           { print("succeed2")
//               if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
//               {
//                   if object.type == AVMetadataObject.ObjectType.qr
//                   {
//                     session.stopRunning()
//                       let alert = UIAlertController(title: "QR Code", message: object.stringValue, preferredStyle: .alert)
//                       alert.addAction(UIAlertAction(title: "Retake", style: .default, handler: nil))
//                       alert.addAction(UIAlertAction(title: "Copy", style: .default, handler: { (nil) in
//                           UIPasteboard.general.string = object.stringValue
//
//                       }))
//
//                       present(alert, animated: true, completion: nil)
//                  let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
//                 navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
//
//
//
//                   }
//               }
//           }
//       }
//
    /////setUp Scanner QRCode
       func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
           if metadataObjects.count > 0{
               let machineReadableCode = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
               if machineReadableCode.type == AVMetadataObject.ObjectType.qr {
                  let stringURL = machineReadableCode.stringValue!
                   print("\n\\n\n\(stringURL)\n\n\n")
                   
                   
                   //self.checkDataQRCode(stringURL)
                   
                   let vc = storyboard?.instantiateViewController(withIdentifier: "CardBillViewController") as! CardBillViewController
                                  navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
                                            
                   self.session.stopRunning()
               }
           }
       }

       override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
           // Dispose of any resources that can be recreated.
       }


    
    ///////Open Home  page //////////////////////////////////////////////
    
    @IBAction func backClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
