//
//  foodStoreClass.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 10/5/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import Foundation
class foodStoreClass {
    var foodName:String?
    var foodPrice:String?
    var foodCoin:String?
    var foodQokkyCoin:String?
    var foodImage:String?
    init(foodName:String?,foodPrice:String?,foodCoin:String?,foodQokkyCoin:String?,foodImage:String?){
        self.foodName = foodName
        self.foodPrice = foodPrice
        self.foodCoin = foodCoin
        self.foodQokkyCoin = foodQokkyCoin
        self.foodImage = foodImage
    }
    
}
