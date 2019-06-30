//
//  MyTipResponse.swift
//  WeYouMaster
//
//  Created by alireza on 6/15/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct MyTipResponse : Decodable {
    public var  tip_id : String
    public var  tip_title : String
    public var  tip_link : String
    public var  tip_subtitle : String
}
