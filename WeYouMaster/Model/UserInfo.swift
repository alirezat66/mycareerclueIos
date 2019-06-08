//
//  UserInfo.swift
//  WeYouMaster
//
//  Created by alireza on 1/25/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct UserInfo : Decodable {
    var  profId : String
    var userName : String ;
    var photo : String;
    var location : String;
    var education : String;
    var bio : String;
    var  followByMe : Int;
    var likesCount: Int;
    var followingCount : Int;
    var purchasedCount : Int;
}
