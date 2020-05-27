//
//  SpecialRewardClass.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 27/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import Foundation

class SpecialRewardClass {
    var rewardID:String?
    var rewardImage:String?
    var useCoin:String?
    
    init(rewardID:String?,rewardImage:String?,useCoin:String?) {
        self.rewardID = rewardID
        self.rewardImage = rewardImage
        self.useCoin = useCoin
    }
}
