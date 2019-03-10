//
//  ResourceCell.swift
//  WeYouMaster
//
//  Created by alireza on 3/10/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class ResourceCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lyEdit: UIView!
    @IBAction func btnDelete(_ sender: Any) {
    }
    @IBAction func btnEdit(_ sender: Any) {
    }
    public func updateView(source : Resource,isOwner : Bool){
        if(isOwner){
            lyEdit.isHidden = false
        }else {
            lyEdit.isHidden = true
        }
        imageFromServerURL(urlString: source.resPic)
        lblTitle.text = source.resTitle
        var desc = ""
        if(source.phone != ""){
            desc = desc + " " + "شماره تماس:  " + source.phone
        }
        if(source.email != ""){
            desc = desc + " ایمیل: " + source.email
        }
        if (source.address != ""){
            desc = desc + "آدرس : " + source.address
        }
        
        lblDesc.text = desc
    
    
    
    }
    func imageFromServerURL(urlString: String) {
        self.img.image = UIImage.init(named:"data_collection_img.png" )
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                
                return
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.img.image = image
            })
            
        }).resume()
    }
   

}
