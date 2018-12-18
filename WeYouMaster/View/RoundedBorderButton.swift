//
//  RoundedBorderButton.swift
//  WeYouMaster
//
//  Created by alireza on 11/14/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class RoundedBorderButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderWidth = 1 / UIScreen.main.nativeScale
       
        contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
         layer.cornerRadius = frame.height/2
        layer.borderColor = tintColor.cgColor

    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
