//
//  NewItemViewController.swift
//  GeoMarket
//
//  Created by Jose Santiago Jr on 10/11/14.
//  Copyright (c) 2014 GJ2. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import CoreGraphics

class NewItemViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var selectFromCamRollBtn: UIButton!
    @IBOutlet weak var takePicBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return descriptionTxt.sizeThatFits(CGSizeMake(descriptionTxt.frame.size.width, CGFloat.max)).height
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n"){
            self.hideKeyboard()
            return false;
        }else{
            return true;
        }
    }
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n"){
            self.hideKeyboard()
            return false;
        }else{
            return true;
        }
    }
    
    
    @IBAction func postForSale(sender: AnyObject) {
        self.hideKeyboard()
        var listing: Ad = Ad(descript: descriptionTxt.text, title: titleTxt.text, price: (priceTxt.text as NSString).floatValue)
        GeoMarketAPI.sharedInstance.postAd(titleTxt.text, descript: descriptionTxt.text, price: (priceTxt.text as NSString).floatValue, success: { (adID:NSString) -> () in
            
            GeoMarketAPI.sharedInstance.postAdImage(adID, image: self.productImage.image!, success: { () -> () in
                
            }, error: { () -> () in
                
            })
            
        }) { () -> () in
            
        }
        
    }
    
    @IBAction func selectFromCameraRoll(sender: AnyObject) {
        var picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
        self.presentViewController(picker, animated: true, completion: nil);
    }
    
    @IBAction func takePic(sender: AnyObject) {
        var picker : UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = UIImagePickerControllerSourceType.Camera;
        self.presentViewController(picker, animated: true, completion: nil);
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo editingInfo: [NSObject : AnyObject]) {
        var chosenImage:UIImage = editingInfo[UIImagePickerControllerEditedImage] as UIImage;
        productImage.image = chosenImage;
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func hideKeyboard(){
        descriptionTxt.resignFirstResponder()
        priceTxt.resignFirstResponder()
        titleTxt.resignFirstResponder()
    }
    
}