//
//  MyTipList.swift
//  WeYouMaster
//
//  Created by alireza on 6/15/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct MyTipList : Decodable {
    let records : [MyTipResponse]
    let errors : [NormalResponse]
}
