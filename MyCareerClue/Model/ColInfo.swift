//
//  ColInfo.swift
//  WeYouMaster
//
//  Created by alireza on 3/22/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct ColInfo  : Decodable{
    let title : String
    let description : String
    let owner : String
    let profilePic : String;
    let followedByMe: Int
    let price : String
    let startDate  : String
    let education : String
    let owner_name : String
    let place : String
    let cur_en : String
    let cur_fa : String
    let boughtByMe : Int
}
