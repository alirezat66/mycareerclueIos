//
//  PadingLable.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class PadingLable: UILabel {

    override func draw(_ rect: CGRect) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = self.frame
        rectShape.position = self.center
        rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        
        self.layer.backgroundColor = UIColor.orange.cgColor
        //Here I'm masking the textView's layer with rectShape layer
        self.layer.mask = rectShape

    }

}
