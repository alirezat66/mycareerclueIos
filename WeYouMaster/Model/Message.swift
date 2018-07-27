//
//  Message.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation

struct Message {
    public var mid : String
    public var user: User
    public var content : String
    public var date : String
    public var type : UInt
    
    
    init(mid : String , user : User , content : String , date : String
        ,type : UInt) {
        self.user = user
        self.mid = mid
        self.content = content
        self.date = date
        self.type = type
    }
    
}
