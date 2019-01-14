//
//  Conversation.swift
//  WeYouMaster
//
//  Created by alireza on 7/23/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct Conversation : Decodable {
    var displayName : String
    var displayId : String
    var displayPhoto : String
    var unReadedMessage : Int
    var lastMessage : MessageObj
    
    
}
