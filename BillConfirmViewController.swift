//
//  BillConfirmViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 24/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class BillConfirmViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
     @IBOutlet weak var mainTableView:UITableView!
     @IBOutlet weak var menuTableView:UITableView!
     
    override func viewDidLoad() {
        super.viewDidLoad()

      self.mainTableView.delegate = self
      self.mainTableView.dataSource = self
      self.menuTableView.delegate = self
      self.menuTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    
    

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if(tableView == menuTableView){
              return 2
          }
    else{
        return 1
    }
    }
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == menuTableView){
              let cell = tableView.dequeueReusableCell(withIdentifier: "MenuSummaryTableViewCell", for: indexPath) as! MenuSummaryTableViewCell
              return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "mainTableViewCell", for: indexPath) as! mainTableViewCell
            return cell
        }
          }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(tableView == menuTableView){
            return 160
        }else{
            return 0
        }
      }

}
