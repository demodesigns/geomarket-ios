//
//  GeoMarketAPI.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import Alamofire

class GeoMarketAPI{
    
    let baseURL = "http://geomarket.me:3001"
    var user : User?
    
    
    //Create a singleton instance
    class var sharedInstance : GeoMarketAPI {
        struct Static{
            static var instance: GeoMarketAPI?
            static var token : dispatch_once_t = 0
        }
            
        dispatch_once(&Static.token){
            Static.instance = GeoMarketAPI(user:nil)
        }
        return Static.instance!
    }
    
    class func registerUser(username:String, email:String, password:String, success:(()->())?){
        let userInfo = [
            "email": email,
            "username": username,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://geomarket.me:3001/users/create", parameters: userInfo, encoding: .JSON).responseJSON { (request, response, data, error) -> Void in
            if(success != nil){
                success!()
            }
        }
    }
    
    class func loginUser(username:String, password:String, success:(()->())?){
        let userInfo = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://geomarket.me:3001/users/login", parameters: userInfo, encoding: .JSON).responseJSON { (request, response, JSON, error) -> Void in
            
            if let jsonResult = JSON as? Dictionary<String, AnyObject>{
                println(jsonResult)
                var userToken = jsonResult["data"]!["user"]!
                println(jsonResult["data"])
                println(userToken?["accessToken"]!)
                //GeoMarketAPI.sharedInstance.assignUser(User(authToken: userToken, username: username))
                
                if(success != nil){
                    success!()
                }
            }else{
                // User failed authentication
            }
        }
    }
    
    func assignUser(user:User){
        self.user = user
    }
    
    init(user: User?){
        self.user = user
    }
    
}