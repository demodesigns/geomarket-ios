//
//  SignUpViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/11/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit


class SignUpViewController : UIViewController{
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    @IBAction func registerUser(sender: AnyObject) {
        GeoMarketAPI.registerUser(usernameTxt.text, email: emailTxt.text, password: passwordTxt.text, success: {()-> () in
            self.presentingViewController!.presentingViewController!.dismissViewControllerAnimated(true, nil)
        },
            error: {() -> () in
                var alert : UIAlertView = UIAlertView(title: "Registration Failed", message: "Please be sure to fill\nall required fields", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
        })
    }
    
    @IBAction func cancelRegistration(sender: AnyObject) {
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