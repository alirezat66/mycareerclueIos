//
//  RoundedButton.swift
//  WeYouMaster
//
//  Created by alireza on 7/16/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    override func draw(_ rect: CGRect) {
        layer.cornerRadius=5.0
        
        layer.backgroundColor = UIColor(red:0, green:0   , blue:180, alpha:CGFloat(1)).cgColor
        setBackgroundColor(UIColor(red:34, green:0   , blue:90, alpha:CGFloat(1)), for: UIControlState.highlighted)
        
    }
    func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setBackgroundImage(colorImage, for: state)
    }
    
}
