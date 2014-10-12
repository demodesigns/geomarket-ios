//
//  ForgottenPasswordViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit

class ForgottenPasswordViewController : UIViewController{
    @IBAction func cancelRequest(sender: AnyObject){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // HANDLE KEYBOARD NOTIFICATIONS FOR TEXT FIELD
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let info: NSDictionary = sender.userInfo {
            let value: NSValue = info.valueForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
            var rect: CGRect = value.CGRectValue()
            rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - rect.size.height, self.view.frame.size.width, self.view.frame.size.height)
            self.view.frame = rect
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let info: NSDictionary = sender.userInfo {
            let value: NSValue = info.valueForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
            var rect: CGRect = value.CGRectValue()
            rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + rect.size.height, self.view.frame.size.width, self.view.frame.size.height)
            self.view.frame = rect
        }
    }
}