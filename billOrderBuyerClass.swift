//
//  billOrderBuyerClass.swift
//  QokkyAppProject
//
//  Created by Schoo Wer on 17/4/2564 BE.
//  Copyright © 2564 Phongsakorn Srikate. All rights reserved.
//

import Foundation
class billOrderBuyerClass {
    var foodName:String?
   
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
