//
//  HomeScreenViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/11/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit

class HomeScreenViewController : UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var searchTxt: UITextField!
    
    var userInfo : NSMutableDictionary = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        navigationItem.backBarButtonItem?.title = ""
        searchTxt.layer.cornerRadius = 5
        
        if (userInfo.count == 0)
        {
            self.performSegueWithIdentifier("loginModal", sender: nil)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n"){
            textField.resignFirstResponder()
            return false;
        }else{
            return true;
        }
    }
    
    func postSearch() -> Void{
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    
}

