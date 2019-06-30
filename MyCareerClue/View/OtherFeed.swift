//
//  OtherFeed.swift
//  WeYouMaster
//
//  Created by alireza on 9/3/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class OtherFeed: UITableViewCell {

    @IBOutlet weak var lblcollectionName : UILabel!
    @IBOutlet weak var lbltitle : UILabel!
    @IBOutlet weak var lblContent : UILabel!
    @IBOutlet weak var btnMore : UIButton!
    @IBOutlet weak var btnLink : UIButton!
     @IBOutlet weak var heightOutlet: NSLayoutConstraint!
     var myContent  : Content = Content()
    var contentText : String = ""
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
    @IBAction func btnMoreAct(_ sender: Any) {
        if isLabelAtMaxHeight {
            btnMore.setTitle("more", for: .normal)
            isLabelAtMaxHeight = false
            heightOutlet.constant = 70
            layoutIfNeeded()
        }
        else {
            btnMore.setTitle("less", for: .normal)
            isLabelAtMaxHeight = true
            heightOutlet.constant = getLabelHeight(text: contentText, width: self.bounds.width, font: lblContent.font)
            layoutIfNeeded()
        }
    }
    @IBAction func btnAttach(_ sender: Any) {
         let url = URL(string: "https://www.dataplusscience.com/VizConfusion.html") 
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    public func updateView(content : Content){
        myContent = content
    lblcollectionName.text = content.collectionName
        lbltitle.text = content.title
        lblContent.text = content.contentText
        
        if(content.linkAddress==""){
            btnLink.isHidden = true
            layoutIfNeeded()
        }else{
            btnLink.isHidden = false
        }
        
        
        if((content.contentText?.count)!>200){
            btnMore.isHidden = false
        }else{
            btnMore.isHidden = true
            layoutIfNeeded()
        }
        
        heightOutlet.constant = 70
        contentText = content.contentText!
        heightOutlet.constant = 70
        layoutIfNeeded()
        if(content.allignment != nil){
        if(content.allignment != "rtl"){
            lbltitle.textAlignment = .left
            lblContent.textAlignment = .left
        }else {
            lbltitle.textAlignment = .right
            lblContent.textAlignment = .right
        }
        
        }
    }
    

}
