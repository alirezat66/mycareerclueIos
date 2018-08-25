//
//  DetailCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/21/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

    var isLiked = false
    var isExtend = false
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnMoreOutLet: UIButton!
    @IBOutlet weak var imgLike: UIButton!
    @IBOutlet weak var imgPic: UIImageView!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var btnOutlet: UIButton!
    @IBAction func btnLike(_ sender: Any) {
        isLiked = !isLiked
        if isLiked {
            imgLike.setImage(UIImage(named: "liked"), for: .normal)
        }else{
             imgLike.setImage(UIImage(named: "like"), for: .normal)
        }
    }
    @IBOutlet weak var viewImageConstraint: NSLayoutConstraint!
    @IBAction func btnMore(_ sender: UIButton) {
        isExtend = !isExtend
        if(isExtend){
            btnMoreOutLet.setTitle("کمتر",for: .normal)
            lblText.numberOfLines = 0
        }else{
             btnMoreOutLet.setTitle("بیشتر",for: .normal)
            lblText.numberOfLines  = 4

        }
    }
    
    
    func updateView(content : Content) {
        
        let titleStr = content.title
        lblTitle.text = titleStr
        
       
            btnOutlet.isEnabled = false
        
        if content.contentType == 2 {
            imageFromServerURL(urlString: content.imgSource)
            
        }else {
            viewImageConstraint.constant = 0
            imgPic.isHidden = true
            layoutIfNeeded()
        }
  
        lblText.text = content.contentText
        
        
        
    }
    
    public func imageFromServerURL(urlString: String) {
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imgPic.image = image
            })
            
        }).resume()
    }
    
    
   
    
    
    
}
