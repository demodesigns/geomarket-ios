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

class NewItemViewController: UITableViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var priceTxt: UITextField!
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var productImg: UITableViewCell!
    @IBOutlet weak var selectFromCamRollBtn: UIButton!
    @IBOutlet weak var takePicBtn: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.section == 1){
            return descriptionTxt.sizeThatFits(CGSizeMake(descriptionTxt.frame.size.width, CGFloat.max)).height
        }
        return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
        
//        var gradient: CAGradientLayer = CAGradientLayer()
//        gradient.frame = view.bounds;
//        gradient.colors = [UIColor(red: 0.102, green: 0.161, blue: 0.502, alpha: 1.0),UIColor(red: 0.149, green: 0.816, blue: 0.808, alpha: 1.0)]
//        gradient.locations = [0.0,1.0]
//        self.tableView.backgroundView = UIView(frame: self.tableView.frame)
//        var backgroundView : UIView = self.tableView.backgroundView!
//        backgroundView.layer.insertSublayer(gradient, atIndex: 1)
        
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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary) {
        var chosenImage:UIImage = editingInfo[UIImagePickerControllerEditedImage] as UIImage;
        productImg.imageView?.image = chosenImage;
    }
    
    func hideKeyboard() -> Void{
        descriptionTxt.resignFirstResponder()
        priceTxt.resignFirstResponder()
        titleTxt.resignFirstResponder()
    }
    
}