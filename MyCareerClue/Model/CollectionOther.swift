//
//  CollectionOther.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct CollectionOther : Decodable {
    public var owner_name : String
    public var owner_lName : String
    public var ownerDegree : String
    public var collection_owner_image : String
    public var collection_image : String

    public var collection_place : String
    public var collection_posts_number : Int
    public var Collection_Title : String
    public var Collection_Description : String
    public var collection_price : String
    public var Link : String
    public var Published_Date : String
    public var Align : String
    public var followByMe : Int
    
    public var collectionId : String;
    public var urlOfCollection : String;
   
}
