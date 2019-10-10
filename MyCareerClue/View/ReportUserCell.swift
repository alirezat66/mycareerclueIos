//
//  ReportUserCell.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class ReportUserCell: UITableViewCell {

    var onButtonTapped : (() -> Void)? = nil
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBAction func btnUnBlock(_ sender: Any) {
        if let onButtonTapped = self.onButtonTapped {
            onButtonTapped()
        }
    }
    public func updateView(content : ReportObject){
        lblTitle.text = content.title
    }

}
