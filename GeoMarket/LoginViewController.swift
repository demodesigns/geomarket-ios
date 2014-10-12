//
//  LoginViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/11/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController : UIViewController{

    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    var keyboardVisible: Bool = false
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    @IBAction func loginUser(sender: AnyObject) {
        GeoMarketAPI.loginUser(usernameTxt.text, password: passwordTxt.text, success: { () -> () in
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        },
        error: {() -> () in
            var alert : UIAlertView = UIAlertView(title: "Authentication Failed", message: "Please check your\nusername and password", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        })
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
            if(!keyboardVisible){
                keyboardVisible = true
                let value: NSValue = info.valueForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
                var rect: CGRect = value.CGRectValue()
                rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - rect.size.height, self.view.frame.size.width, self.view.frame.size.height)
                self.view.frame = rect
            }
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        if let info: NSDictionary = sender.userInfo {
            if(keyboardVisible){
                keyboardVisible = false
                let value: NSValue = info.valueForKey(UIKeyboardFrameEndUserInfoKey) as NSValue
                var rect: CGRect = value.CGRectValue()
                rect = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + rect.size.height, self.view.frame.size.width, self.view.frame.size.height)
                self.view.frame = rect
            }
        }
    }
}