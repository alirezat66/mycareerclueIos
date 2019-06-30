//
//  CollectionExpendedCell.swift
//  WeYouMaster
//
//  Created by alireza on 12/6/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class CollectionExpendedCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var view : UIView!
    @IBOutlet weak var img: UIImageView!
    public func updateView(message : ExpendedCollection){
      
        view.backgroundColor  = UIColor.white
        lblText.textColor = UIColor.black
        lblText.text = message.collection.collectionName
        if(message.collection.chapters.count>0){
            img.isHidden = false
            if(message.open){
                img.image = UIImage(named: "down-arrow.png")
                
            }else{
                img.image = UIImage(named: "left-arrow-1.png")
            }
        }else{
            img.isHidden = true
        }
        
    }
    public func updateView(message : chapter){
        view.backgroundColor = UIColor.init(displayP3Red: 19.0/255, green: 142.0/255, blue: 255.0/255, alpha: 1.0)
        lblText.textColor = UIColor.white
        lblText.text = message.chapterName
        img.isHidden = true
    }
}
