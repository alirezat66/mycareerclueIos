//
//  BottomBorder.swift
//  WeYouMaster
//
//  Created by alireza on 9/8/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class BottomBorder: UITextView {

    func addBottomBorder(){
        var bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, myTextField.frame.height - 1, myTextField.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.whiteColor().CGColor
        myTextField.borderStyle = UITextBorderStyle.None
        myTextField.layer.addSublayer(bottomLine)
        
    }

}
