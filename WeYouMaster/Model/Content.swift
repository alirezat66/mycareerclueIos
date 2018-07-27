//
//  Content.swift
//  WeYouMaster
//
//  Created by alireza on 7/21/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct Content {
    public var fName : String
    public var lName : String
    public var education : String
    public var location : String
    public var collectionName : String
    public var title : String
    public var contentText : String
    public var ownerPic : String
    public var contentType : UInt32 // 1== text 2 == img 3==video 4== sound
    public var linkAddress : String // linke marboot be marjaa
    public var likeByMe : Bool // man likesh kardam ya na
    public var imgSource:String  // source ax
    public var hasMore:Bool
    public var price :String
    
    init(fName : String , lName : String , education : String,
         location : String , collectionName:String , title : String,
         contentText : String , contentType : UInt32 , linkAddress : String,
         likeByMe : Bool , imgSource : String , hasMore : Bool , price : String , ownerPic : String) {
        self.fName = fName
        self.lName = lName
        self.education = education
        self.location = location
        self.collectionName = collectionName
        self.title = title
        self.linkAddress = linkAddress
        self.contentText = contentText
        self.contentType = contentType
        self.likeByMe = likeByMe
        self.imgSource = imgSource
        self.hasMore = hasMore
        self.price = price
        self.ownerPic = ownerPic;
    }
    
    
    
}
