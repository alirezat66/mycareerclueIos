//
//  Posts.swift
//  WeYouMaster
//
//  Created by alireza on 9/3/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct Posts : Decodable {
    let posts : [Content]
    let collection : [CollectionCollect]
}
