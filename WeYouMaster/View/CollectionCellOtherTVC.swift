//
//  CollectionCellOtherTVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class CollectionCellOtherTVC: UITableViewCell {
    var onButtonTapped : (() -> Void)? = nil
    @IBOutlet weak var btnShow: UIButton!
    var onButtonTappedOnShow : (() -> Void)? = nil
    var onTitleTappedOnShow : (() -> Void)? = nil
    var onPricingTap : (() -> Void)? = nil
    var onButtonDelete : (() -> Void)? = nil
    var onButtonEdit : (() -> Void)? = nil
    @IBOutlet weak var priceButton: UIButton!
    @IBAction func showClick(_ sender: Any) {
        if let onButtonTappedOnShow = self.onButtonTappedOnShow {
            onButtonTappedOnShow()
        }
    }
    
    @IBAction func onEditButton(_ sender: Any) {
        if let onButtonEdit = self.onButtonEdit {
        onButtonEdit()
        }
    }
    @IBAction func onDeleteButton(_ sender: Any) {
        if let onButtonDelete = self.onButtonDelete {
            onButtonDelete()
        }
    }
    @IBAction func onPriceButton(_ sender: Any) {
        if let onPricingTap = self.onPricingTap {
            onPricingTap()
        }
    }
    @IBAction func imageClicked(_ sender: Any) {
        
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        if let onTitleTappedOnShow = self.onTitleTappedOnShow {
            onTitleTappedOnShow()
        }
    }
    @IBOutlet weak var collectionTitle : UILabel!
    @IBOutlet weak var collectionNumberFields : UILabel!
    @IBOutlet weak var collectionOwner : UILabel!
    @IBOutlet weak var collectionOwnerLocation : UILabel!
    @IBOutlet weak var collectionOwnerImage : UIButton!
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(8, 8, 8, 8))
    }
  
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    func updateView(collection : CollectionOther, isOwner : Bool)  {
        // collectionOwnerImage.image = UIImage(named: collection.img)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        collectionTitle.isUserInteractionEnabled = true
        collectionTitle.addGestureRecognizer(tap)
        if(!isOwner){
            btnEdit.isHidden = true
            btnDelete.isHidden = true
            priceButton.isHidden = true
        }else{
            priceButton.backgroundColor = .white
            priceButton.layer.cornerRadius = 5
            priceButton.layer.borderWidth = 1
            priceButton.layer.borderColor = UIColor.purple.cgColor
            btnShow.backgroundColor = .orange
            btnShow.setTitle("مشارکت جدید", for: .normal)
            
        }
        collectionOwnerImage.layer.cornerRadius = collectionOwnerImage.frame.size.width/2
        collectionOwnerImage.clipsToBounds = true
        
        if( collection.collection_owner_image != "" )
        {
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
        }
        
        
        collectionTitle.text = collection.Collection_Title
        let name  = collection.owner_name + " " + collection.owner_lName
        collectionOwner.text = name
        
        let mosharekat = " از تاریخ " + collection.Published_Date + " شامل " + String(collection.collection_posts_number) + " پست "
        collectionNumberFields.text = mosharekat
        
        collectionOwnerLocation.text = collection.collection_place
        
        collectionOwnerLocation.text = collection.ownerDegree
        
    }
 
}
