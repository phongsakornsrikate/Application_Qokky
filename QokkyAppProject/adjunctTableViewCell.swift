//
//  adjunctTableViewCell.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 14/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import UIKit

class adjunctTableViewCell: UITableViewCell {
    @IBOutlet weak var adjunctDetailLabel:UILabel!
    @IBOutlet weak var adjunctPriceLabel:UILabel!
    @IBOutlet weak var adjunctCount:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    @IBAction func addAdjunct(_ sender:Any){
   
        let Count = Int(adjunctCount.text!)
        if(Count! >= 0 && Count! < 9){
            adjunctCount.text = "0\(String(Count! + 1))"

        }else if(Count! >= 9){
            adjunctCount.text = String(Count! + 1)
        }
       
    }
    
    @IBAction func deleteAdjunct(_ sender:Any){
         let Count = Int(adjunctCount.text!)
            if(Count! > 0 && Count! < 10){
                adjunctCount.text = "0\(String(Count! - 1))"

            }else if(Count! > 0){
                adjunctCount.text = String(Count! - 1)
            }
           
    }
    
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
