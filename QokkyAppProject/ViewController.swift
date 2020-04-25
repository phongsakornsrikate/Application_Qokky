//
//  ViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 21/1/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth
class ViewController: UIViewController {

    @IBOutlet weak var FBLoginBtn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let loginButton = FBLoginButton(permissions: [.publicProfile])
//        loginButton.center = view.center
//        self.view.addSubview(loginButton)
    }
    
    @IBAction func FBLoginClicked(_ sender:Any){
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
               if (error == nil){
                   let fbloginresult : LoginManagerLoginResult = result!
                   
                   print("condition true")
                   
                   // if user cancel the login
                   if (result?.isCancelled)!{
                       return
                   }
                   if(fbloginresult.grantedPermissions.contains("email"))
                       
                   {
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                       Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                           if error != nil {
                               print("Erorrนิ่")
                               print(error!.localizedDescription)
                               return
                           }else{
                           print("Log in sucseed")
                                let userUID = Auth.auth().currentUser?.uid
                               
          // tokenLoginFacebook              //      let accessToken = FBSDKAccessToken.current().tokenString
                              // print("token"+accessToken!)
                              
                             
                           }
                       }
                   }
               }else{
                   print("error is not null")
               }
           }
       }
       

}

