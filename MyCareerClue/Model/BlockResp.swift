//
//  BlockResp.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct BlockResp : Decodable{
    let profileId : String
    let reporterId : String
    let error : Int
    let errorMessage : String
}
