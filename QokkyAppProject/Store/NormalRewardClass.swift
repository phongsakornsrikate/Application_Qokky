//
//  NormalRewardClass.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 27/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import Foundation
class NormalRewardClass{
    var rewardID:String?
    var rewardImage:String?
    var useCoin:String?
    var rewardTitle:String?
    var rewardDetail:String?
    init(rewardID:String?,rewardImage:String?,useCoin:String?,rewardTitle:String?,rewardDetail:String?) {
        self.rewardID = rewardID
        self.rewardImage = rewardImage
        self.useCoin = useCoin
        self.rewardTitle = rewardTitle
        self.rewardDetail = rewardDetail
    }
}
