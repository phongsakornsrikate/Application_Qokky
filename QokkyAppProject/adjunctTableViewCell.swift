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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}