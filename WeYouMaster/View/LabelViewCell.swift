//
//  LabelViewCell.swift
//  WeYouMaster
//
//  Created by alireza on 12/3/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class LabelViewCell: UICollectionViewCell {
    var onButtonTapped : (() -> Void)? = nil

    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    @IBAction func deleteBtnPush(_ sender: Any) {
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
}
