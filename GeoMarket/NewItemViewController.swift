//
//  NewItemViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/11/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit

class NewItemViewController: UITableViewController, UITextViewDelegate {
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return descriptionTxt.sizeThatFits(CGSizeMake(descriptionTxt.frame.size.width, CGFloat.max)).height
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
    }
    
    override func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.hideKeyboard()
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            self.hideKeyboard()
            return false;
        }else{
            return true;
        }
    }
    
    @IBAction func postForSale(sender: AnyObject) {
        self.hideKeyboard()
    }
    
    func hideKeyboard() -> Void{
        descriptionTxt.resignFirstResponder()
        priceTxt.resignFirstResponder()
        titleTxt.resignFirstResponder()
    }
    
}