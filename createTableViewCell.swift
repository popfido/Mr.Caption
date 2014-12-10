//
//  createTableViewCell.swift
//  MrCaption
//
//  Created by YlLUN WAN on 12/9/14.
//  Copyright (c) 2014 YlLUN WAN. All rights reserved.
//

import UIKit

class createTableViewCell: UITableViewCell {
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var titleString: UITextField!
    
    func loadItem(#title:String,imageStr: String) {
        backgroundImage.image = UIImage(named: imageStr)
        titleString.text = title
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        // Configure the view for the selected state
    }
    
}
