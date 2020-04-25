//
//  CardBillSummaryViewController.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 19/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class CardBillSummaryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var billSummaryTableView:UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

      self.billSummaryTableView.delegate = self
      self.billSummaryTableView.dataSource = self
    }
    

    //////////////Bill summary TableView /////////////////////
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billSummaryTableViewCell", for: indexPath) as! billSummaryTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 102
    }

}
