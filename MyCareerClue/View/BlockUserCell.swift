//
//  BlockUserCell.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class BlockUserCell: UITableViewCell {
     var onButtonTapped : (() -> Void)? = nil
     @IBOutlet weak var lblTitle: UILabel!

    @IBAction func btnUnBlock(_ sender: Any) {
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
     public func updateView(content : BlockObject){
        lblTitle.text = content.first_name+" "+content.last_name
    }
}
