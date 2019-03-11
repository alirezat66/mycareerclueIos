//
//  CollectionChapter.swift
//  WeYouMaster
//
//  Created by alireza on 3/11/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct CollectionChapter : Decodable {
    let  chapterId : String
let  followByMe : Int
    
    let Owner : String
    let owner_name : String
    let owner_lName : String
    let ownerDegree : String
    let collection_owner_image : String
    let collection_image : String
    let collection_place : String
    let collection_posts_number : Int
    let collection_price : String
    let Collection_Title : String
    let Collection_Description : String
    let Link : String
    let Published_Date : String
    let Align : String
}
