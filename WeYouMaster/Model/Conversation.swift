//
//  Conversation.swift
//  WeYouMaster
//
//  Created by alireza on 7/23/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct Conversation {
    var fName : String
    var lName : String
    var shortText : String
    var lblTime : String
    var count : String
    var imgSource : String
    init(fName : String , lName : String , shortText : String
        ,lblTime : String , count : String,imgSource : String) {
        self.fName = fName
        self.lName  = lName
        self.shortText = shortText
        self.lblTime  = lblTime
        self.count = count
        self.imgSource = imgSource
    }
    
    
}
