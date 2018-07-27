//
//  CollectionCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

    
    @IBOutlet weak var collectionTitle : UILabel!
    @IBOutlet weak var collectionNumberFields : UILabel!
    @IBOutlet weak var collectionOwner : UILabel!
    @IBOutlet weak var collectionOwnerLocation : UILabel!
    @IBOutlet weak var collectionOwnerImage : UIImageView!
    @IBOutlet weak var collectionPrice : UILabel!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(8, 8, 8, 8))
    }
    func updateView(collection : Collection)  {
        collectionOwnerImage.image = UIImage(named: collection.img)
        collectionOwnerImage.layer.cornerRadius = collectionOwnerImage.frame.size.width/2
        collectionOwnerImage.clipsToBounds = true
        
        collectionTitle.text = collection.title
        let name  = collection.fName + " " + collection.lName
        collectionOwner.text = name
        let mosharekat = "(" + String(collection.numberOfPost) + "مشارکت " + ")"
        collectionNumberFields.text = mosharekat
        
        collectionOwnerLocation.text = collection.place
        
        collectionPrice.text = collection.price
    }
}
