//
//  HomeOtherCell.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import ExpandableLabel
class HomeOtherCell: UITableViewCell {

    
    var onButtonTapped : (() -> Void)? = nil
    @IBAction func btnCollection(_ sender: Any) {
    }
    @IBOutlet weak var btnCollection: UIButton!
    
    @IBOutlet weak var imgPerson: UIButton!
    @IBOutlet weak var lblOwner: UILabel!
    
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
    var myContent  : OtherContent = OtherContent()
    var contentText : String = ""
    @IBAction func btnAttach(_ sender: Any) {
        guard let url = URL(string: myContent.linkAddress) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func imageClicked(_ sender: Any) {
        
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
    func imageFromServerURL(urlString: String) {
        self.imgContent.image = UIImage.init(named:"data_collection_img.png" )
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
    @IBOutlet weak var lblContent: ExpandableLabel!
    var isLiked = false
    var isLabelAtMaxHeight = false
    
   /* func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        
        return lbl.frame.size.height
    }*/
 /*   @IBAction func btnMore(_ sender: Any) {
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
    }*/
    @IBAction func btnLike(_ sender: Any) {
        isLiked = !isLiked
        if isLiked {
            
            callLike()
            likeCounter  = likeCounter + 1
            btnLikeOutlet.titleLabel!.font  =  UIFont(name: btnLikeOutlet.titleLabel!.font.fontName, size: 21)!
            
        }else{
            callDisLike()
            likeCounter = likeCounter - 1
            
            btnLikeOutlet.titleLabel!.font  =  UIFont(name: btnLikeOutlet.titleLabel!.font.fontName, size: 19)!
        }
        lblLikeCounter.text = "(" + String( likeCounter) + ")"
    }
    
    func callLike() {
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let owner = userDefaults.value(forKey: "owner") as! String
        let otherowner = userDefaults.value(forKey: "otherUser") as! String
        
        WebCaller.likeAndDisLike(0, owner, myContent.postId , liked_id : otherowner) { (state, error) in
            if let error = error{
                print(error)
                return
            }
            guard let state = state else{
                print("error getting collections")
                return
            }
            if(state == 1 ){
                print("like done")
            }
        }
    }
    func callDisLike() {
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let owner = userDefaults.value(forKey: "owner") as! String

        let otherOwner = userDefaults.value(forKey: "otherUser") as! String
        
        WebCaller.likeAndDisLike(1, owner, myContent.postId,liked_id: otherOwner) { (state, error) in
            if let error = error{
                print(error)
                return
            }
            guard let state = state else{
                print("error getting collections")
                return
            }
            if(state == 1 ){
                print("like done")
            }
        }
        
    }
    @IBOutlet weak var lblCollectionTitle: UILabel!
    public func updateView(content : OtherContent){
        self.myContent = content
        contentText = content.contentText
       /* if(content.allignment != "rtl"){
            lblTitle.textAlignment = .left
            lblContent.textAlignment = .left
        }else {
            lblTitle.textAlignment = .right
            lblContent.textAlignment = .right
        }*/
        if(content.collectionName == ""){
            btnCollection.isHidden = true
            lblCollectionTitle.isHidden = true
            layoutIfNeeded()
        }else{
            
            btnCollection.isHidden = false
            lblCollectionTitle.isHidden = false
        }
        let userDefaults = UserDefaults.standard
       
        let otherImage = userDefaults.value(forKey: "otherImage") as! String
        if(otherImage != "")
        {
            self.loader.startAnimating()
            let url = URL(string : otherImage)
            self.imgPerson.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgPerson.setBackgroundImage(image, for: .normal)
                            self?.loader.stopAnimating()
                            self?.imgPerson.layoutIfNeeded()
                            self?.imgPerson.subviews.first?.contentMode = .scaleAspectFill
                        }
                    }
                }
            }
        }else{
            self.imgPerson.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)
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
        
        if content.contentType == 2 {
            imageFromServerURL(urlString: content.imgSource)
            imgContent.isHidden = false
            imgConstrant.constant = 200
            
        }else {
            imgConstrant.constant = 0
            imgContent.isHidden = true
        }
        
        
        
        
    }
}
