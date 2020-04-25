//
//  cardViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 27/2/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import  Firebase

class cardViewController: UIViewController {
    @IBOutlet weak var handleArea:UIView!
    @IBOutlet weak var handleCloseBtn:UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    //////log out  //////////////////
      @IBAction func logOutClicked(_ sender: Any) {
     
         do{
             try Auth.auth().signOut()
            print("log out succeed")
            let vc = LoginViewController() //change this to your class name
            self.present(vc, animated: true, completion: nil)
            

         } catch let error as NSError{
             print(error.localizedDescription)
             
         }
     
     }

}
