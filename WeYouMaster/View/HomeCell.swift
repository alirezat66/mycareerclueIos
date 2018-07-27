//
//  HomeCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

   
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblOwner: UILabel!
    
   
    @IBOutlet weak var btnLikeOutlet: UIButton!
    @IBOutlet weak var imgConstrant: NSLayoutConstraint!
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var btnShowLink: UIButton!
    @IBOutlet weak var btnMoreOutLet: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblCollection: UILabel!
    @IBOutlet weak var lblPlaceAndTime: UILabel!
    @IBOutlet weak var lblEducation: UILabel!
    @IBAction func btnAttach(_ sender: Any) {
        guard let url = URL(string: "https://www.dataplusscience.com/VizConfusion.html") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBOutlet weak var lblContent: UILabel!
    var isLiked = false
    var isExtend = false
    
    
    @IBAction func btnMore(_ sender: Any) {
        isExtend = !isExtend
        if(isExtend){
            btnMoreOutLet.setTitle("کمتر",for: .normal)
            lblContent.numberOfLines = 0
            
        }else{
            btnMoreOutLet.setTitle("بیشتر",for: .normal)
            lblContent.numberOfLines  = 4
            layoutIfNeeded()
            
        }
    }
    @IBAction func btnLike(_ sender: Any) {
        isLiked = !isLiked
        if isLiked {
            btnLikeOutlet.setImage(UIImage(named: "liked"), for: .normal)
        }else{
            btnLikeOutlet.setImage(UIImage(named: "like"), for: .normal)
        }
    }
    
    public func updateView(content : Content){
        imgPerson.image = UIImage(named: content.ownerPic)
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        let name = content.fName + " " + content.lName
        lblOwner.text = name
        lblTitle.text = content.title
        lblCollection.text = content.collectionName
        lblEducation.text = content.education
        lblPlaceAndTime.text = content.location
        lblContent.text = content.contentText
        
        if content.contentType == 2 {
            imageFromServerURL(urlString: content.imgSource)
            
        }else {
            imgConstrant.constant = 0
            imgContent.isHidden = true
            layoutIfNeeded()
        }
        
    }
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imgContent.image = image
            })
            
        }).resume()
    }
    
    
}
