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
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
    }
    
    @IBAction func loginUser(sender: AnyObject) {
        GeoMarketAPI.loginUser(usernameTxt.text, password: passwordTxt.text, success: { () -> () in
            self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
        })
    }
}