//
//  MainCollection.swift
//  WeYouMaster
//
//  Created by alireza on 12/6/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct MainCollection : Decodable {
    let collection : String
    let  collectionName : String
    let chapters : [chapter]
}
