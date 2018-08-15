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
       // collectionOwnerImage.image = UIImage(named: collection.img)
        collectionOwnerImage.layer.cornerRadius = collectionOwnerImage.frame.size.width/2
        collectionOwnerImage.clipsToBounds = true
        
        collectionTitle.text = collection.Collection_Title
        let name  = collection.owner_name + " " + collection.owner_lName
        collectionOwner.text = name
        let mosharekat = "(" + String(collection.collection_posts_number) + "مشارکت " + ")"
        collectionNumberFields.text = mosharekat
        
        collectionOwnerLocation.text = collection.collection_place
        var price : String
        if(collection.collection_price==""){
            price = "رایگان"
        }else{
            price = collection.collection_price + " تومان"
        }
        collectionPrice.text = price
    }
}
