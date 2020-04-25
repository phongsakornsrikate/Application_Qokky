//
//  SearchViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 29/2/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    
          
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return 1
          }
          
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
              let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
              return cell
          }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 1850
      }

    

        /////// Hidden statusbar/////////////////////
        override var prefersStatusBarHidden: Bool{
            return true
        }
    
    
    ///////Open Home  page //////////////////////////////////////////////
    
    @IBAction func backClicked(_ sender:Any){
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
