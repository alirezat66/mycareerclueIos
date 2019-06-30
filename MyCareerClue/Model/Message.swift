//
//  Message.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation

struct Message : Decodable {
    public var senderName : String
    public var receverName: String
    public var message : String
    public var senderId : String
    public var sendedTime : String
    
    
    init(senderName : String , receverName : String , message : String , senderId : String
        ,sendedTime : String) {
        self.senderName = senderName
        self.receverName = receverName
        self.message = message
        self.senderId = senderId
        self.sendedTime = sendedTime
    }
    
}
