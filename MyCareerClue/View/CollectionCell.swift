//
//  CollectionCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class CollectionCell: UITableViewCell {

    var onButtonTapped : (() -> Void)? = nil
    var onButtonTappedOnShow : (() -> Void)? = nil
    @IBOutlet weak var collectionTitle : UILabel!
    @IBOutlet weak var collectionNumberFields : UILabel!
    @IBOutlet weak var collectionOwner : UILabel!
    @IBOutlet weak var collectionOwnerLocation : UILabel!
    @IBOutlet weak var collectionOwnerImage : UIButton!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(8, 8, 8, 8))
    }
    @IBAction func imageClicked(_ sender: Any) {
        
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
    @IBAction func showClick(_ sender: Any) {
        if let onButtonTappedOnShow = self.onButtonTappedOnShow {
            onButtonTappedOnShow()
        }
    }
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        if let onButtonTappedOnShow = self.onButtonTappedOnShow {
            onButtonTappedOnShow()
        }
    }
    func updateView(collection : FollowingResponseRecords) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        collectionTitle.isUserInteractionEnabled = true
        collectionTitle.addGestureRecognizer(tap)
        
        collectionOwnerImage.layer.cornerRadius = collectionOwnerImage.frame.size.width/2
        collectionOwnerImage.clipsToBounds = true
        
        if(collection.ownerPic != "")
        {
            self.collectionOwnerImage.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)
            
            let url = URL(string : collection.ownerPic)
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.collectionOwnerImage.setBackgroundImage(image, for: .normal)
                            self?.collectionOwnerImage.layoutIfNeeded()
                            self?.collectionOwnerImage.subviews.first?.contentMode = .scaleAspectFill
                        }
                    }
                }
            }
        }else{
            self.collectionOwnerImage.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)
            
        }
        
        
        collectionTitle.text = collection.title
        let name  = collection.fName + " " + collection.lName
        collectionOwner.text = name
        let mosharekat = "" + collection.date // + " شامل " + String(collection.) + " پست "
        collectionNumberFields.text = mosharekat
        
        collectionOwnerLocation.text = collection.education
        
        collectionOwnerLocation.text = collection.education
    }
    func updateView(collection : Collection)  {
       // collectionOwnerImage.image = UIImage(named: collection.img)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        collectionTitle.isUserInteractionEnabled = true
        collectionTitle.addGestureRecognizer(tap)
        
        collectionOwnerImage.layer.cornerRadius = collectionOwnerImage.frame.size.width/2
        collectionOwnerImage.clipsToBounds = true
        
        if(collection.collection_owner_image != "")
        {
            self.collectionOwnerImage.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)

            let url = URL(string : collection.collection_owner_image)
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.collectionOwnerImage.setBackgroundImage(image, for: .normal)
                        self?.collectionOwnerImage.layoutIfNeeded()
                        self?.collectionOwnerImage.subviews.first?.contentMode = .scaleAspectFill
                    }
                }
            }
        }
        }else{
            self.collectionOwnerImage.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)

        }
        
        
        collectionTitle.text = collection.Collection_Title
        let name  = collection.owner_name + " " + collection.owner_lName
        collectionOwner.text = name
        let mosharekat = "From " + collection.Published_Date + " include" + String(collection.collection_posts_number) + " clues"
        collectionNumberFields.text = mosharekat
        
        collectionOwnerLocation.text = collection.collection_place
        
        collectionOwnerLocation.text = collection.ownerDegree
        
        
      
        
    }
   
}