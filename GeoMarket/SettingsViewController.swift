//
//  SettingsViewController.swift
//  GeoMarket
//
//  Created by Gene Demo on 10/12/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var myIntValue:Int = Int(GeoMarketAPI.sharedInstance.distance!);
        self.miles.text = "\(myIntValue)";
        loadSlider.value = GeoMarketAPI.sharedInstance.distance!;
    }
    
    @IBOutlet weak var loadSlider: UISlider!
    
    @IBOutlet weak var miles: UILabel!
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        
        var myIntValue:Int = Int(loadSlider.value);
        self.miles.text = "\(myIntValue)";
        GeoMarketAPI.sharedInstance.distance = loadSlider.value;
    }
}
