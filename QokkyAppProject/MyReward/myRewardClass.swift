//
//  myRewardClass.swift
//  QokkyAppProject
//
//  Created by Schoo Wer on 13/4/2564 BE.
//  Copyright © 2564 Phongsakorn Srikate. All rights reserved.
//

import Foundation
class myRewardClass {
    var foodName:String?
    var foodPrice:String?
    var foodImage:String?
    var foodCoin:String?
    var foodID:String?
    var foodSize:String?
    var OrderCount:String?
    var SpecialNeeds:String?
    var FoodOrderID:String?
    init(foodName:String?,foodPrice:String,foodImage:String?,foodCoin:String?,foodID:String?,foodSize:String?,OrderCount:String,SpecialNeeds:String?,FoodOrderID:String?) {
        self.foodName = foodName
        self.foodPrice = foodPrice
        self.foodImage = foodImage
        self.foodCoin = foodCoin
        self.foodID = foodID
        self.foodSize = foodSize
        self.OrderCount = OrderCount
        self.SpecialNeeds = SpecialNeeds
        self.FoodOrderID = FoodOrderID
    }
}
