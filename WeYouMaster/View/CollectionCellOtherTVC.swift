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
    var onButtonTappedOnShow : (() -> Void)? = nil
    @IBAction func showClick(_ sender: Any) {
        if let onButtonTappedOnShow = self.onButtonTappedOnShow {
            onButtonTappedOnShow()
        }
    }
    
    @IBAction func imageClicked(_ sender: Any) {
        
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
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
  
    
    func updateView(collection : CollectionOther)  {
        // collectionOwnerImage.image = UIImage(named: collection.img)
        
        
        
        collectionOwnerImage.layer.cornerRadius = collectionOwnerImage.frame.size.width/2
        collectionOwnerImage.clipsToBounds = true
        
        if(collection.ownerImage != "")
        {
            let url = URL(string : collection.ownerImage)
            
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
        
        
        collectionTitle.text = collection.Title
        let name  = collection.ownerName
        collectionOwner.text = name
        let mosharekat = "از تاریخ " + "تاریخ انتشار نداریم" + " شامل " + "نامشخص" + " پست "
        collectionNumberFields.text = mosharekat
        
        collectionOwnerLocation.text = collection.Ownerlocation
        
        collectionOwnerLocation.text = collection.ownerDegree
        
        
        
        
    }
 
}
