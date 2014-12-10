//
//  CreatPageController.swift
//  MrCaption
//
//  Created by Fido Wang on 9/12/14.
//  Copyright (c) 2014 YlLUN WAN. All rights reserved.
//

import UIKit
import MobileCoreServices

class CreatPageController: UIViewController, ImageCropperDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var imageBox_1: UIImageView!
    @IBOutlet var chooseButton: UIButton!
    var imagePicker = UIImagePickerController()
    var imageCropper = ImageCropper()
    
    @IBAction func Clear_1(sender: UIButton) {
        selectPicFromAlbum()
    }
    
    @IBAction func repicImage(sender: UIButton) {
        /*
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            println("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        */
    }
    
    func selectPicFromAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            //println("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func selectPicFromCamera(){
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            imagePicker.sourceType = .Camera
            
            imagePicker.mediaTypes = [kUTTypeImage as NSString]
            
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            
            presentViewController(imagePicker, animated: true, completion: nil)

        }
    }
    
    func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
            
            if let types = availableMediaTypes{
                for type in types{
                    if type == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        
        imageBox_1.image = image
        
        imageCropper = ImageCropper(image: image)
        
        imageCropper.delegate = self
        
        presentViewController(imageCropper, animated: true, completion: nil)
        
        
        
    }
    
    func imageCropper(cropper: ImageCropper!, didFinishCroppingWithImage image: UIImage!){
        imageBox_1.image = image
    }
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as NSString, sourceType: .Camera)
    }
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Front) || UIImagePickerController.isCameraDeviceAvailable(.Rear)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            println("The camera is available")
        } else {
            println("The camera is not available")
        }
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
