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
    @IBOutlet weak var lyLink: UIView!
    @IBOutlet weak var btnLink2: UIButton!
    @IBOutlet weak var btnLink1: UIButton!
    @IBOutlet weak var btnLink3: UIButton!
    
    @IBOutlet weak var lblType: UILabel!
    var link1  : String = ""
    var link2 : String = ""
    var link3 : String = ""
    @IBAction func btnLinkOne(_ sender: Any) {
        guard let url = URL(string:link1) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func btnLinkTwo(_ sender: Any) {
        guard let url = URL(string:link2) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func btnLinkThree(_ sender: Any) {
        guard let url = URL(string:link3) else { return }
        UIApplication.shared.open(url)
    }
    @IBAction func btnDelete(_ sender: Any) {
    }
    @IBAction func btnEdit(_ sender: Any) {
    }
    public func updateView(source : Resource,isOwner : Bool){
        link1 = source.lnk1
        link2 = source.lnk2
        link3 = source.lnk3
        if(isOwner){
            lyEdit.isHidden = false
            lyLink.isHidden = true
        }else {
            lyEdit.isHidden = true
            lyLink.isHidden  =  false
        }
        imageFromServerURL(urlString: source.resPic)
        lblTitle.text = source.resTitle
        lblType.text = "Resource Type: " + source.resType
        if(source.lnk1 == ""){
            btnLink1.isHidden = true
        }else {
            btnLink1.isHidden = false
        }
        if(source.lnk2 == ""){
            btnLink2.isHidden = true
        }else {
            btnLink2.isHidden = false
        }
        if(source.lnk3 == ""){
            btnLink3.isHidden = true
        }else {
            btnLink3.isHidden = false
        }
        
        lblDesc.text = source.resBio
        
        self.img.layer.cornerRadius = self.img.frame.size.width/2
        self.img.clipsToBounds = true
    
       
    
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
