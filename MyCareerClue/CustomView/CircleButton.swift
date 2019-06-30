//
//  CircleButton.swift
//  WeYouMaster
//
//  Created by alireza on 8/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    @IBInspectable var fillColor : UIColor = UIColor.white
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = layer.frame.size.width/2
        layer.masksToBounds = true
        layer.backgroundColor = fillColor.cgColor
        
    }

}
