//
//  MessageObj.swift
//  WeYouMaster
//
//  Created by alireza on 1/12/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct MessageObj : Decodable {
    var mid : String
    var mtype : String
    var to :  String
    var timestamp : String ;
    var content : String
    var size :   Int
}
