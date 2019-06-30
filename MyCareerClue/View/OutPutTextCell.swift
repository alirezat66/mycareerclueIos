//
//  OutPutTextCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class OutPutTextCell: UITableViewCell {

    @IBOutlet weak var lblText: UILabel!
    
    @IBOutlet weak var backView: UIView!
    public func updateView(message : Message) {
        lblText.text = message.message
        backView.layer.cornerRadius = 5
        backView.layer.masksToBounds = true
       /* let maskPath = UIBezierPath(roundedRect: lblText.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = lblText.bounds
        maskLayer.path  = maskPath.cgPath
        lblText.layer.mask = maskLayer*/
        

        
    }
    
}
