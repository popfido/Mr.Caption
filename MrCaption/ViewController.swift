//
//  ViewController.swift
//  MrCaption
//
//  Created by YlLUN WAN on 12/2/14.
//  Copyright (c) 2014 YlLUN WAN. All rights reserved.
//

import UIKit
import MobileCoreServices

class addTableViewCell: UITableViewCell {
    @IBOutlet var addImgBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


//原创页面代码
class createPageViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet var tableView: UITableView!
    
    
    //默认文字及图片生成
    var items: [(String,String)] = [
        ("相见时难别亦难(编辑)","create_exampleimg"),
        ("东风无力百花残(编辑)","create_exampleimg2Rotate"),
        ("春蚕到死丝方尽(编辑)","create_exampleimg3")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var createPageViewController = self

        
        //设置格子类型
        var nib = UINib(nibName: "createTableViewCell", bundle: nil)
        var nib2 = UINib(nibName: "addTableViewCell", bundle: nil)
        var nib3 = UINib(nibName: "watermarkTableViewCell", bundle: nil)
        var nib4 = UINib(nibName: "bottomTableViewCell", bundle: nil)


        tableView.registerNib(nib, forCellReuseIdentifier: "createCell")
        tableView.registerNib(nib2, forCellReuseIdentifier: "addCell")
        tableView.registerNib(nib3, forCellReuseIdentifier: "watermarkCell")
        tableView.registerNib(nib4, forCellReuseIdentifier: "bottomCell")

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        println("rows count = #\(items.count)")
        if section == 0{
        return items.count
        }
        return 3
    
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:createTableViewCell = tableView.dequeueReusableCellWithIdentifier("createCell") as createTableViewCell
        var addcell:addTableViewCell = tableView.dequeueReusableCellWithIdentifier("addCell") as addTableViewCell
        var watercell:watermarkTableViewCell = tableView.dequeueReusableCellWithIdentifier("watermarkCell") as watermarkTableViewCell
        var bottomcell:bottomTableViewCell = tableView.dequeueReusableCellWithIdentifier("bottomCell") as bottomTableViewCell
             println("image set#\(indexPath.row)")
       
        if (indexPath.section == 0) {
        var (title,image) = items[indexPath.row]
        cell.loadItem(title:title, imageStr:image)
        return cell
        }
        if (indexPath.section == 1 && indexPath.row == 0){
            return watercell
        }
        if (indexPath.section == 1 && indexPath.row == 1){
        return addcell
        }
        
        return bottomcell
        
    }
    
    /**
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath!){
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    println("You selected cell at section \(indexPath.section), row at #\(indexPath.row)!")
    switch indexPath.row
    {
    case 0:
    println("111")
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    let content = cell?.contentView
    SJAvatarBrowser.showImage(content?.subviews[0] as UIImageView)
    case 1:
    println("222")
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    let content = cell?.contentView
    SJAvatarBrowser.showImage(content?.subviews[0] as UIImageView)
    case 2:
    println("333")
    
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    let content = cell?.contentView
    
    SJAvatarBrowser.showImage(content?.subviews[0] as UIImageView)
    
    case 3:
    let alert = UIAlertController(title: "还在画的说～",
    message: "On the way laaaa~",
    preferredStyle: .Alert)
    let action = UIAlertAction(title: "嗯啊", style: .Default,
    handler: nil)
    alert.addAction(action)
    presentViewController(alert,animated: true, completion: nil)
    default:
    println("false")
    }
    }
    **/
    

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        tableView.reloadData()
        }
    }
    

    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?  {
        // 1
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "拖出" ,  handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 2
            /**
            let shareMenu = UIAlertController(title: nil, message: "拖出去？",preferredStyle: .Alert)
            
            let confirmDeleteAction = UIAlertAction(title: "斩了", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "且慢", style: UIAlertActionStyle.Cancel, handler: nil)
            
            shareMenu.addAction(cancelAction)
            shareMenu.addAction(confirmDeleteAction)
            

            
            
            self.presentViewController(shareMenu, animated: true, completion: nil)
  **/
            self.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)

            tableView.reloadData()
            
        })

            

        // 3


    
    
     /**
        var rotateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Rate" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            // 4
            let rateMenu = UIAlertController(title: nil, message: "Rate this App", preferredStyle: .ActionSheet)
            
            let appRateAction = UIAlertAction(title: "Rate", style: UIAlertActionStyle.Default, handler: nil)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            
            rateMenu.addAction(appRateAction)
            rateMenu.addAction(cancelAction)
            
            
            self.presentViewController(rateMenu, animated: true, completion: nil)
        })
       **/
        // 5
      //  return [deleteAction,rotateAction]
         return [deleteAction]
    }
    
    // Return Availability of Taking photo
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
    
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as NSString, sourceType: .Camera)
    }
    
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Front) || UIImagePickerController.isCameraDeviceAvailable(.Rear)
    }
    
    func selectPicFromAlbum(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary){
            //println("Button capture")
            
            // replace image picker with an self Defined ImagePicker to Enable this function
            /* like this in class:
                
            var imagePicker = UIImagePickerController()
            var imageCropper = ImageCropper()

            */
            //imagePicker.delegate = self
            //imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            //imagePicker.allowsEditing = true
            
            //self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    func selectPicFromCamera(){
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            /* Same as function "selectPicFromAlbum */
            
            //imagePicker.sourceType = .Camera
            
            //imagePicker.mediaTypes = [kUTTypeImage as NSString]
            
            //imagePicker.allowsEditing = true
            //imagePicker.delegate = self
            
            //presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        
        // replace image Cropper with an self Defined ImageCropper to Enable this function
        /* like this in class:
        
        var imageCropper = ImageCropper()
        
        */
        
        //imageBox_1.image = image
        
        //imageCropper = ImageCropper(image: image)
        
        //imageCropper.delegate = self
        
        //presentViewController(imageCropper, animated: true, completion: nil)
    }
    
    func imageCropper(cropper: ImageCropper!, didFinishCroppingWithImage image: UIImage!){
        // replace imageBox_1 with an outside ImageView to Enable this function
        
        //imageBox_1.image = image
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

