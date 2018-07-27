//
//  User.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct User {
    public var id : String
    public var name : String;
    public var  avatar : String
    private var online : Bool
    
    init(id : String , name : String , avatar: String , online : Bool) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.online  = online
    }
}
