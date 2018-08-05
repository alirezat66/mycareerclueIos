//
//  InputTextCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class InputTextCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var backView: UIView!
    public func updateView(message : Message){
        lblText.text = message.content
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
    }
    
}
