//
//  HomeCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBAction func btnCollection(_ sender: Any) {
        print(btnCollection.titleLabel?.text)
    }
    @IBOutlet weak var btnCollection: UIButton!
    
    @IBOutlet weak var imgPerson: UIImageView!
    @IBOutlet weak var lblOwner: UILabel!
    @IBOutlet weak var heightOutlet: NSLayoutConstraint!
    
    @IBOutlet weak var btnLikeOutlet: UIButton!
    @IBOutlet weak var lblLikeCounter : UILabel!
    @IBOutlet weak var loader : UIActivityIndicatorView!
    @IBOutlet weak var imgConstrant: NSLayoutConstraint!
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var btnShowLink: UIButton!
    @IBOutlet weak var btnMoreOutLet: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPlaceAndTime: UILabel!
    @IBOutlet weak var lblEducation: UILabel!
    
    
    
    var likeCounter : Int = 0
    var contentText : String = ""
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

    func imageFromServerURL(urlString: String) {
        self.loader.startAnimating()
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                
                return
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imgContent.image = image
                self.loader.stopAnimating()
            })
            
        }).resume()
    }
    @IBOutlet weak var lblContent: UILabel!
    var isLiked = false
    var isLabelAtMaxHeight = false
    
    func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        
        return lbl.frame.size.height
    }
    @IBAction func btnMore(_ sender: Any) {
        if isLabelAtMaxHeight {
            btnMoreOutLet.setTitle("بیشتر", for: .normal)
            isLabelAtMaxHeight = false
            heightOutlet.constant = 70
        }
        else {
            btnMoreOutLet.setTitle("کمتر", for: .normal)
            isLabelAtMaxHeight = true
            heightOutlet.constant = getLabelHeight(text: contentText, width: self.bounds.width, font: lblContent.font)
        }
    }
    @IBAction func btnLike(_ sender: Any) {
        isLiked = !isLiked
        if isLiked {
            likeCounter  = likeCounter + 1
            btnLikeOutlet.titleLabel!.font  =  UIFont(name: btnLikeOutlet.titleLabel!.font.fontName, size: 21)!

        }else{
            likeCounter = likeCounter - 1
            
            btnLikeOutlet.titleLabel!.font  =  UIFont(name: btnLikeOutlet.titleLabel!.font.fontName, size: 19)!
        }
        lblLikeCounter.text = "(" + String( likeCounter) + ")"
    }
    
    
    @IBOutlet weak var lblCollectionTitle: UILabel!
    public func updateView(content : Content){
        heightOutlet.constant = 70
        contentText = content.contentText
        if(content.allignment != "rtl"){
            lblTitle.textAlignment = .left
            lblContent.textAlignment = .left
        }else {
            lblTitle.textAlignment = .right
            lblContent.textAlignment = .right
        }
        if(content.collectionName == ""){
            btnCollection.isHidden = true
            lblCollectionTitle.isHidden = true
            layoutIfNeeded()
        }else{
            
            btnCollection.isHidden = false
            lblCollectionTitle.isHidden = false
        }
        if(content.ownerPic != "")
        {
            self.loader.startAnimating()
            let url = URL(string : content.ownerPic)
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgPerson.image = image
                            self?.loader.stopAnimating()
                        }
                    }
                }
            }
        }else{
            self.imgPerson.image = UIImage(named: "hacker.png")
            self.loader.stopAnimating();

        }
        
        if(content.linkAddress==""){
            btnShowLink.isHidden = true
            layoutIfNeeded()
        }else{
            btnShowLink.isHidden = false
        }
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        let name = content.fName + " " + content.lName
        lblOwner.text = name
        lblTitle.text = content.title
        btnCollection.setTitle(content.collectionName, for: .normal)

        lblEducation.text = content.education
        lblPlaceAndTime.text = content.date + " | " +  content.location
        lblContent.text = content.contentText
        likeCounter = content.likeCount
        lblLikeCounter.text = "(" + String( content.likeCount) + ")"
        if(content.likeByMe==1){
            isLiked = true
        }else{
            isLiked = false
        }
        if isLiked {
            btnLikeOutlet.titleLabel!.font  =  UIFont(name: btnLikeOutlet.titleLabel!.font.fontName, size: 21)!
        }else{
            btnLikeOutlet.titleLabel!.font  =  UIFont(name: btnLikeOutlet.titleLabel!.font.fontName, size: 19)!
            
        }
        if(content.contentText.count>200){
            btnMoreOutLet.isHidden = false
        }else{
            btnMoreOutLet.isHidden = true
            layoutIfNeeded()
        }
        
        if content.contentType == 2 {
            imageFromServerURL(urlString: content.imgSource)
            
        }else {
            imgConstrant.constant = 0
            imgContent.isHidden = true
        }
 
 
 
        
    }
    
     
    
    
}
