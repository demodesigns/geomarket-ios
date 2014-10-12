//
//  GeoMarketAPI.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit
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
    
    class func registerUser(username:String, email:String, password:String, success:(()->())?, error:(()->())?){
        let userInfo = [
            "email": email,
            "username": username,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://geomarket.me:3001/users/create", parameters: userInfo, encoding: .JSON).responseString { (request, response, data, reqError) -> Void in
            if(response?.statusCode == 200){
                self.extractUserDataFromResponse(data)
                
                if(success != nil && self.sharedInstance.user != nil){
                    success!()
                }
            }else{
                // User failed authentication
                if(error != nil)
                {
                    error!();
                }
            }
        }
    }
    
    class func loginUser(username:String, password:String, success:(()->())?, error:(()->())?){
        let userInfo = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(.POST, "http://geomarket.me:3001/users/login", parameters: userInfo, encoding: .JSON).responseString{ (request, response, data, reqError) -> Void in
            if(response?.statusCode == 200){
                self.extractUserDataFromResponse(data)
     
                if(success != nil && self.sharedInstance.user != nil){
                    success!()
                }
            }else{
                // User failed authentication
                if(error != nil)
                {
                    error!();
                }
            }
            
        }
        
    }
    
    func assignUser(user:User){
        self.user = user
    }
    
    class func extractUserDataFromResponse(data:String?){
        var convertedData: NSData = (data! as String).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        var responseJSON : NSDictionary = NSJSONSerialization.JSONObjectWithData(convertedData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
        var authToken = responseJSON["data"]!["user"]!?["accessToken"] as NSString
        var username = responseJSON["data"]!["user"]!?["username"] as NSString
        
        GeoMarketAPI.sharedInstance.assignUser(User(authToken: authToken, username: username))
    }
    
    init(user: User?){
        self.user = user
    }
    
}