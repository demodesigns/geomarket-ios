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
    
    var baseURL = "http://geomarket.me:3001" //"http://172.31.183.102:3001"
    var user : User?
    var distamce: Float? = 0.0
    
    
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
        
        Alamofire.request(.POST, "\(GeoMarketAPI.sharedInstance.baseURL)/users/create", parameters: userInfo, encoding: .JSON).responseString { (request, response, data, reqError) -> Void in
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
        
        Alamofire.request(.POST, "\(GeoMarketAPI.sharedInstance.baseURL)/users/login", parameters: userInfo, encoding: .JSON).responseString{ (request, response, data, reqError) -> Void in
            println(response)
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
    
    func postAd(title:NSString, descript: NSString, price: Float, success: ((adID:NSString)->())?, error: (()->())?){
        let adInfo = [
            "title": title,
            "price": price,
            "description": descript,
            "accessToken": GeoMarketAPI.sharedInstance.user?.authToken as NSString!
        ]
        Alamofire.request(.POST, "\(GeoMarketAPI.sharedInstance.baseURL)/ads", parameters: adInfo, encoding: .JSON).responseString{ (request, response, data, reqError) -> Void in
            println(response)
            if(response?.statusCode == 200){
                
                var convertedData: NSData = (data! as String).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                var responseJSON : NSDictionary = NSJSONSerialization.JSONObjectWithData(convertedData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                var adID = responseJSON["data"]!["ad"]!?["_id"] as NSString
                
                if(success != nil){
                    success!(adID: adID)
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
    
    func postAdImage(adID:NSString, image:UIImage, success: (()->())?, error: (()->())?){
            
        var tempPath:String? = NSTemporaryDirectory()!.stringByAppendingPathComponent("tmp.png")
        
        UIImagePNGRepresentation(image).writeToFile(tempPath!, atomically: true)
        
        var url: NSURL = NSURL(string: tempPath!)
        
        Alamofire.upload(.POST, "\(GeoMarketAPI.sharedInstance.baseURL)/ads/\(adID)/\(GeoMarketAPI.sharedInstance.user?.authToken as NSString!)", url).progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
            println(totalBytesWritten)
            }
            .responseString{ (request, response, data, reqError) -> Void in
                println(response)
                if(response?.statusCode == 200){
                    
                    if(success != nil){
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
    
    func getLocalAds(success:((options:NSArray)->())?,error:(()->())?){
        Alamofire.request(.GET, "\(GeoMarketAPI.sharedInstance.baseURL)/ads?accessToken=\(GeoMarketAPI.sharedInstance.user?.authToken as NSString!)", parameters: nil, encoding: .JSON).responseString{ (request, response, data, reqError) -> Void in
            println(response)
            if(response?.statusCode == 200){
                
                var convertedData: NSData = (data! as String).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                var responseJSON : NSDictionary = NSJSONSerialization.JSONObjectWithData(convertedData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                var options = responseJSON["data"]!["ads"]! as NSArray
                
                if(success != nil){
                    println(options)
                    success!(options: options)
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
    
    func searchAds(searchTerms: String, success:((options:NSArray)->())?,error:(()->())?){
        Alamofire.request(.GET, "\(GeoMarketAPI.sharedInstance.baseURL)/ads?accessToken=\(GeoMarketAPI.sharedInstance.user?.authToken as NSString!)", parameters: nil, encoding: .JSON).responseString{ (request, response, data, reqError) -> Void in
            println(response)
            if(response?.statusCode == 200){
                
                var convertedData: NSData = (data! as String).dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
                var responseJSON : NSDictionary = NSJSONSerialization.JSONObjectWithData(convertedData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                var options = responseJSON["data"]!["ads"]! as NSArray
                
                if(success != nil){
                    println(options)
                    success!(options: options)
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
    
}