//
//  User.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation

class User : NSObject {
    
    var authToken: String? = ""
    var username: String? = ""
    
    init(authToken:String, username: String) {
        self.authToken = authToken
        self.username = username
    }
    
}