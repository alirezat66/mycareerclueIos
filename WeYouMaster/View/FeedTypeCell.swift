//
//  FeedTypeCell.swift
//  WeYouMaster
//
//  Created by alireza on 12/6/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class FeedTypeCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    public func updateView(message : String){
        
        
        lblText.text = message
        
        
    }
}
