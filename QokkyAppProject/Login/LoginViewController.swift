//
//  LoginViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 23/1/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FacebookLogin
import GoogleSignIn
import FirebaseFirestore


class LoginViewController: UIViewController,GIDSignInDelegate {
    
    
    

    @IBOutlet weak var activity:UIActivityIndicatorView!
    @IBOutlet weak var FBLoginBtn:UIButton!
    @IBOutlet weak var GoogleLoginBtn:UIButton!
    
    let database = Firestore.firestore()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //            let loginButton = FBLoginButton(permissions: [.publicProfile])
        //            loginButton.center = view.center
        //            self.view.addSubview(loginButton)
        
        self.activity.isHidden = true
        GIDSignIn.sharedInstance()?.delegate = self
        
        // Automatically sign in the user.
        
        //        let gSighin = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 48))
        //                     gSighin.center = view.center
        //                     // ...
        //                     view.addSubview(gSighin)
    }
    
    //    func convertToDictionary(text: String) -> [String: Any]? {
    //        if let data = text.data(using: .utf8) {
    //            do {
    //                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:       Any]
    //            } catch {
    //                print(error.localizedDescription)
    //            }
    //        }
    //        return nil
    //    }
    //
    /////// google login function
    @IBAction func GoogleLoginClicked(_ sender:Any){
       
      
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
       //loggedIn
       
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
        }
        
        
        /////check user isCanceled loginj
        if(GIDSignIn.sharedInstance()?.currentUser == nil)
                    {
                        print("555")
                        return
               }
               
        guard let authentication = user.authentication else {
            return
        }
        if self.activity.isAnimating == false{
                              self.activity.isHidden = false
                              self.activity.startAnimating()
      
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil{
                print("google login error")
                return
            }
            else{
                let userUID = Auth.auth().currentUser?.uid
                print("errorjjjjj")
                self.database.collection("Users").document(userUID!).setData([
                   
                    "name": user.profile.name!,
                    "google_id": user.userID!,
                    "first_name": user.profile.givenName!,
                    "last_name": user.profile.familyName!,
                    "email": user.profile.email!,
                ])
                print("erortttt")
                 print(user.profile.hasImage)
                if user.profile.hasImage == true{
                    let dimension = round(100 * UIScreen.main.scale)
                    let picture = user.profile.imageURL(withDimension: UInt(dimension))
                    let url = picture?.absoluteString // converse url to sring
                    self.database.collection("Users").document(userUID!).updateData([
                        "userImageUrl": url!,
                    ])
               }
                self.navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
                print("google login succeed")
                
            }
            }
        }else{
            self.activity.isHidden = true
            self.activity.stopAnimating()
        }
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
      
        print("user has didconnected")
    }
    
    
    
    /// Facebook login function  ////////////////////////
    @IBAction func FBLoginClicked(_ sender:Any){
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
            if (error == nil){
                let fbloginresult : LoginManagerLoginResult = result!
                
                print("condition true")
                //print(result)
                print(fbloginresult.grantedPermissions)
                // if user cancel the login
                if (result?.isCancelled)!{
                    return
                }
                if(fbloginresult.grantedPermissions.contains("email"))
                    
                {
                    if self.activity.isAnimating == false{
                        self.activity.isHidden = false
                        self.activity.startAnimating()
                    print("succeedGetId")
                    ////////////// get token facebook Api
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    print(credential)
                    
                    Auth.auth().signIn(with: credential) { (authResult, error) in
                        if error != nil {
                            print("Erorrนิ่")
                            print(error!.localizedDescription)
                            return
                        }else{
                            print("Log in sucseed")
                            let userUID = Auth.auth().currentUser!.uid
                            guard error == nil else {
                                print(error)
                                return
                            }
                            print(userUID)
                            self.getFBUserData(userUID)
                        }
                    }
                    }else{
                        self.activity.isHidden = true
                        self.activity.stopAnimating()
                    }
            }
            
            }
            
        }
        
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        //////////  Get token Api facebook Sighin
        //            let usr_2 = URL(string: "https://graph.facebook.com/oauth/access_token?client_id=512998399568579&client_secret=7f86aae5e81663f83724e2108aae8bcc&grant_type=client_credentials")!
        //
        //            URLSession.shared.dataTask(with: usr_2, completionHandler: { (data, response, error) in
        //
        //                // do some logic here from data, error
        //                guard error == nil else {
        //                    print("failure")
        ////                    self.handle(.failure(error!))
        //                    return
        //                }
        //                print("success")
        //                let result = self.convertToDictionary(
        //                    text: String(bytes: data!, encoding: .utf8)!
        //                )
        //                print(result)
        //                var token: Any;
        //                token = result!["access_token"]!
        //
        //                print(token)
        //
        //            }).resume()
        ////
        //            func handle(_ result: Result<Data,Error>) {
        //                switch result {
        //                case let .success(data):
        //                    break
        //                case let .failure(error):
        //                    break
        //                }
        //            }
        //
        //
        
        ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    }
    
    
    
    
    //////// get data users facebookLogin   /////////////////
    func getFBUserData(_ userUID:String){
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name,last_name, email, picture.type(large),relationship_status"]).start(completionHandler: { (connection, result, error) -> Void in
            if (error == nil){
                let fbDetails = result as! NSDictionary
                // let name = fbDetails["name"] as! String
                print(fbDetails)
                guard let Info = result as? [String: Any] else { return }
                if let imageURL = ((Info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    print(imageURL)
                    self.savedataIntoDatabase(fbDetails, userUID,imageURL)
                }
            }
        })
        
        
    }
    
    
    
    /////  save data user facebook login//////////
    func savedataIntoDatabase(_ fbDetails:NSDictionary,_ userUID:String,_ imageURL:String){
        let name = fbDetails["name"] as! String
        let id = fbDetails["id"] as! String
        let Firstname = fbDetails["first_name"] as! String
        let Lasttname = fbDetails["last_name"] as! String
        let userEmail = fbDetails["email"] as! String
        let userImageUrl = imageURL
        //let data: [ NSDictionary] = [name,id,Firstname,userEmail ]
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.database.collection("Users").document(userUID).setData([
            "name": name,
            "facebook_id": id,
            "first_name": Firstname,
            "last_name": Lasttname,
            "email": userEmail,
            "userImageUrl": userImageUrl
        ])
        
        navigationController?.pushViewController(vc, animated: true)   ///// go to HomePage
        
        
        
    }
    
    
    
    /////// Hidden statusbar/////////////////////
//    override var prefersStatusBarHidden: Bool{
//        return true
//    }
//
}








