//
//  menuTableViewCell.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 18/4/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class menuTableViewCell: UITableViewCell {

    @IBOutlet weak var foodNameLabel:UILabel!
    @IBOutlet weak var foodPriceLabel:UILabel!
    @IBOutlet weak var foodCoinLabel:UILabel!
    @IBOutlet weak var foodImage:UIImageView!
    @IBOutlet weak var orderCountLabel:UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    ///////add food order  //////////////////////////////////////////////
    
    @IBAction func addFoodOrder(_ sender:Any){
        var orderCount = Int(orderCountLabel.text!) ?? 00
        orderCount += 1
        if(orderCount < 10){
            orderCountLabel.text = "0\(String(orderCount))"
        }else{
            orderCountLabel.text = String(orderCount)
        }
    }
    
    
    @IBAction func reduceFoodOrder(_ sender:Any){
           var orderCount = Int(orderCountLabel.text!) ?? 00
           if(orderCount == 00){
                      orderCountLabel.text = "00"
                }
           else if(orderCount < 10){
               orderCount -= 1
               orderCountLabel.text = "0\(String(orderCount))"
           }
           else{
               orderCount -= 1
               orderCountLabel.text = String(orderCount)
           }
       }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
