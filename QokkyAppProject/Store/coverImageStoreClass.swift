//
//  coverImageStoreClass.swift
//  QokkyAppProject
//
//  Created by Phongsakorn Srikate on 12/3/2563 BE.
//  Copyright © 2563 Phongsakorn Srikate. All rights reserved.
//

import Foundation
import FirebaseFirestore

class coverImageStoreClass {
    var coverImageUrl:String?
    init(coverImageUrl:String?) {
        self.coverImageUrl = coverImageUrl
    }
}
