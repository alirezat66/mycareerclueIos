//
//  CommentList.swift
//  WeYouMaster
//
//  Created by alireza on 8/29/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct LikeList : Decodable {
    let error : Int
    let errorMessage : String
    let records : [LikeFollow]
}
