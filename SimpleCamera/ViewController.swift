//
//  ViewController.swift
//  SimpleCamera
//
//  Created by Ricardo Hui on 22/12/2015.
//  Copyright © 2015 Ricardo Hui. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var loadPhotoButton: UIButton!
    
    
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadPhotoButton.setTitle("Load Image", forState: UIControlState.Normal)
        loadPhotoButton.sizeToFit()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadImageButtonTapped(sender: UIButton) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil{
            
        imagePicker.allowsEditing = false
//        imagePicker.sourceType = .PhotoLibrary
        imagePicker.sourceType = .Camera
        imagePicker.cameraCaptureMode = .Photo
        imagePicker.modalPresentationStyle = .FullScreen
        
        //imagePicker.modalPresentationStyle = .Popover
        presentViewController(imagePicker, animated: true, completion: nil)
        //imagePicker.popoverPresentationController?.barButtonItem


        }else{
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message:"Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC,animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .ScaleAspectFill
            imageView.image = pickedImage
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil);
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

