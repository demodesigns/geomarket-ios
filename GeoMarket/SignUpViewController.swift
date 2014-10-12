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
    
}