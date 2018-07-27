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
    
    public func updateView(message : Message){
        lblText.text = message.content
    }
    
}
