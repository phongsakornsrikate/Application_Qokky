//
//  foodStoreClass.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 12/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import Foundation

class foodStoreClass {
    var foodName:String?
    var foodPrice:String?
    var foodImage:String?
    var foodCoin:String?
    init(foodName:String?,foodPrice:String,foodImage:String?,foodCoin:String?) {
        self.foodName = foodName
        self.foodPrice = foodPrice
        self.foodImage = foodImage
        self.foodCoin = foodCoin
    }
}
