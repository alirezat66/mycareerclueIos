//
//  InfoObject.swift
//  WeYouMaster
//
//  Created by alireza on 3/18/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct InfoObject : Decodable {
    let profId : Int
    let userName  : String
    let  photo : String
    let  location : String
    let education : String
    let  bio : String
    let  followByMe : Int
}
