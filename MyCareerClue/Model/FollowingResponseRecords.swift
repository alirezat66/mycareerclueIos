//
//  FollowingResponseRecords.swift
//  WeYouMaster
//
//  Created by alireza on 6/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct FollowingResponseRecords : Decodable {
    public var date : String
    public var lName : String
    public var fName : String
    public var  education : String
    public var owner_id : String
    public var ownerPic : String
    public var contentText : String
    public var allignment : String
    public var linkAddress : String
    public var title : String
    public var collectionId : String
}
