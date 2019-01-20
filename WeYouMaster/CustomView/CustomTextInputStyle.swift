//
//  CustomTextInputStyle.swift
//  WeYouMaster
//
//  Created by alireza on 1/20/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct CustomTextInputStyle : AnimatedTextInputStyle {
    
    let activeColor = UIColor.orangeColor()
    let inactiveColor = UIColor.grayColor().colorWithAlphaComponent(0.3)
    let errorColor = UIColor.redColor()
    let textInputFont = UIFont.systemFontOfSize(14)
    let textInputFontColor = UIColor.blackColor()
    let placeholderMinFontSize: CGFloat = 9
    let counterLabelFont: UIFont? = UIFont.systemFontOfSize(9)
    let leftMargin: CGFloat = 25
    let topMargin: CGFloat = 20
    let rightMargin: CGFloat = 0
    let bottomMargin: CGFloat = 10
    let yHintPositionOffset: CGFloat = 7
}
