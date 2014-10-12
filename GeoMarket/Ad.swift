//
//  Ad.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation

class Ad : NSObject {
    
    var title: String? = ""
    var price: Float? = 0.00
    var descript: String? = ""
    
    init(descript:String?, title:String?, price: Float?) {
        self.title = title
        self.price = price
        self.descript = descript
    }
    
}