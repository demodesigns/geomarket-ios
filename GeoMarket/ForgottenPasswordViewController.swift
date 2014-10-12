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
}