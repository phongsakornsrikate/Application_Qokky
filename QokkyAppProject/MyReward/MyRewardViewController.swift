//
//  MyRewardViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 5/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class MyRewardViewController: UIViewController,UITableViewDelegate,UITableViewDataSource  {

    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    

    
    
    ///// set tableView /////////////////////
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                  return 1
              }
              
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                  let cell = tableView.dequeueReusableCell(withIdentifier: "MyRewardTableViewCell", for: indexPath) as! MyRewardTableViewCell
                  return cell
              }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              return 700
          }
    /////// Hidden statusbar/////////////////////
    override var prefersStatusBarHidden: Bool{
               return false
           }
    
    
    
    @IBAction func back(_ sender:Any){
        
               let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               navigationController?.pushViewController(vc, animated: true)
           
       }
}
