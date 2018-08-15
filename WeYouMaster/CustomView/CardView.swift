//
//  CardView.swift
//  WeYouMaster
//
//  Created by alireza on 8/14/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {

    @IBInspectable var cornerRadiud : CGFloat  = 2
    @IBInspectable var shaddowOffsetWidth : CGFloat = 0
    @IBInspectable var shaddowOffsetHeight : CGFloat = 5
    @IBInspectable var shadowColor : UIColor = UIColor.black
    @IBInspectable var shadowOpacity : CGFloat = 0.6
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadiud
        layer.shadowColor  = shadowColor.cgColor
        layer.shadowOffset = CGSize (width: shaddowOffsetWidth, height: shaddowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadiud)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
        
        
    }
    
}
