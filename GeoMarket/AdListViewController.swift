//
//  AdListViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit

class AdListViewController : UITableViewController, UITableViewDelegate, UITableViewDataSource{
    var options : NSArray = []
    var searchType : NSString = ""
    var searchTerms : NSString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.searchType == ""){
            GeoMarketAPI.sharedInstance.getLocalAds({ (options:NSArray) -> () in
                self.options = options
                self.tableView.reloadData()
                }, error: { () -> () in
                    println("fail")
            })
        }else{
            
            /*
            GeoMarketAPI.sharedInstance.searchAds(searchTerms,{ (options:NSArray) -> () in
                self.options = options
                }, error: { () -> () in
                    println("fail")
            })
            */
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        /*var cell : AdListingCellViewController  = tableView.dequeueReusableCellWithIdentifier("adListCell")
        cell.productTitle.text = options[indexPath.row].objectForKey("title")
        cell.productPrice.text = options[indexPath.row].objectForKey("price")
        cell.productDescription.text = options[indexPath.row].objectForKey("description")
        var imgData:NSData = NSData(contentsOfURL: options[indexPath.row].objectForKey("image")
            cell.productImage.image = UIImage(data: imgData)
        return cell
        */
    }
    
    
}