//
//  HomeCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import MDHTMLLabel
class HomeCell: UITableViewCell,MDHTMLLabelDelegate {
    var onButtonTapped : (() -> Void)? = nil
    var onReportTapped :(()->Void)? = nil
      var onCollectionTap : (() -> Void)? = nil
    var onBtnShowMeTap : (() -> Void)? = nil
     var onTextTap : (() -> Void)? = nil
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        if let onTextTap = self.onTextTap {
            onTextTap()
        }
    }
    @IBAction func btnCollection(_ sender: Any) {
        if let onCollectionTap = self.onCollectionTap {
            onCollectionTap()
        }
    }
    
    @IBOutlet weak var btnShowMe: UIButton!
    @IBAction func btnShowMe(_ sender: Any) {
        if let onBtnShowMeTap = self.onBtnShowMeTap {
            onBtnShowMeTap()
        }
    }
   
    @IBOutlet weak var btnCollection: UIButton!
    
    
    @IBOutlet weak var imgPerson: UIButton!
    @IBOutlet weak var lblOwner: UILabel!
 //   @IBOutlet weak var heightOutlet: NSLayoutConstraint!
    
    @IBOutlet weak var btnLikeOutlet: UIButton!
    @IBOutlet weak var lblLikeCounter : UILabel!
    @IBOutlet weak var loader : UIActivityIndicatorView!
    @IBOutlet weak var imgConstrant: NSLayoutConstraint!
    @IBOutlet weak var imgContent: UIImageView!
    @IBOutlet weak var btnShowLink: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPlaceAndTime: UILabel!
    @IBOutlet weak var lblEducation: UILabel!
    
    
    @IBAction func btnReport(_ sender: Any) {
        if let onReportTapped = self.onReportTapped{
            onReportTapped()
        }
    }
    
    var likeCounter : Int = 0
    var myContent  : Content = Content()
    @IBAction func btnAttach(_ sender: Any) {
        if let onTextTap = self.onTextTap {
            onTextTap()
        }
       /*    guard let url = URL(string: myContent.linkAddress!) else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }*/
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
    @IBOutlet weak var lblText: MDHTMLLabel!
    var isLiked = false
    var isLabelAtMaxHeight = false
    
    /*func getLabelHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        let lbl = UILabel(frame: .zero)
        lbl.frame.size.width = width
        lbl.font = font
        lbl.numberOfLines = 0
        lbl.text = text
        lbl.sizeToFit()
        
        return lbl.frame.size.height
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
        if(likeCounter>0){
            btnShowMe.isHidden = false
        }else{
            btnShowMe.isHidden = true
        }
        
        lblLikeCounter.text = "(" + String( likeCounter) + ")"
    }
    
    func callLike() {
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let owner = userDefaults.value(forKey: "owner") as! String
        
        
        WebCaller.likeAndDisLike(0, owner, String(myContent.postId!) , liked_id: myContent.owner_id!) { (state, error) in
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
        
        
        WebCaller.likeAndDisLike(1, owner, String(myContent.postId!),liked_id: myContent.owner_id!) { (state, error) in
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
   /* @objc func tabbToImageView(sender : UITapGestureRecognizer){
        DispatchQueue.main.async(execute: { () -> Void in
            
        })
    }*/
 /*   public func updateContent(state : Bool , content : Content){
        if(state){
            if(content.contentText!.count > 100)
            {
                let mystr =  content.contentText ?? "" ;
                var hasan = mystr.prefix(100);
                hasan.append(contentsOf: "بیشتر ...");
                let ali = String(hasan)
                lblText.htmlText = ali;
            }
            
        }else{
            var mystr =  content.contentText ?? "" ;
            mystr.append(contentsOf: " کمتر ...")
            lblText.htmlText = content.contentText
            lblText.layoutIfNeeded()
            
        }
    }*/
    public func updateView(content : Content){
        
        self.myContent = content
        
    //   heightOutlet.constant = 70
        
       /* let tabGuester = UITapGestureRecognizer(target: self, action: #selector(tabbToImageView(sender :)))
        tabGuester.numberOfTapsRequired = 1
        imgContent.isUserInteractionEnabled = true
        imgContent.addGestureRecognizer(tabGuester)*/
        
        
       /* lblText.isUserInteractionEnabled = true
        lblText.addGestureRecognizer(tap)*/
        if(content.collectionName == ""){
            btnCollection.isHidden = true
            lblCollectionTitle.isHidden = true
            layoutIfNeeded()
        }else{
            
            btnCollection.isHidden = false
            lblCollectionTitle.isHidden = false
        }
       /*if(content.contentText!.count > 200){
            
            let mystr =  content.contentText ?? "" ;
            
        let hasan = mystr.prefix(200);
            btnShowLink.isHidden = false
            //hasan.append(contentsOf: " بیشتر  ... ");
            let ali = String(hasan)
            lblText.htmlText = ali;
        }else{
            lblText.htmlText = content.contentText
            btnShowLink.isHidden = true
         }*/
        lblText.delegate = self
        lblText.htmlText = content.contentText
        // cell.lblText.text = content.contentText
        
        //cell.lblText.text =  content.contentText.
        lblText.textAlignment = NSTextAlignment.left
        if(content.ownerPic != "")
        {
            self.loader.startAnimating()
            let url = URL(string : content.ownerPic!)
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
        
       /* if(content.linkAddress==""){
            btnShowLink.isHidden = true
            layoutIfNeeded()
        }else{
            btnShowLink.isHidden = false
        }*/
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        
        let name = content.fName! + " " + content.lName!
        lblOwner.text = name
        lblTitle.text = content.title
        btnCollection.setTitle(content.collectionName, for: .normal)

        lblEducation.text = content.education
        lblPlaceAndTime.text = content.date! + " | " +  content.location!
     
        likeCounter = content.likeCount!
        if(likeCounter>0){
            btnShowMe.isHidden = false
        }else{
            btnShowMe.isHidden = true
        }
        lblLikeCounter.text = "(" + String( content.likeCount!) + ")"
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
       /* if(content.contentText!.count>200){
            btnMoreOutLet.isHidden = false
        }else{
            btnMoreOutLet.isHidden = true
            layoutIfNeeded()
        }
        */
        if content.contentType == 2 || content.contentType == 9 {
            imageFromServerURL(urlString: content.imgSource!)
            imgContent.isHidden = false
            imgConstrant.constant = 330
            
            
        }else {
            imgConstrant.constant = 0
            imgContent.isHidden = true
        }
 
 
 
        
    }
    
    
    
    
}
