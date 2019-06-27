//
//  Content.swift
//  WeYouMaster
//
//  Created by alireza on 7/21/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct Content : Decodable {
    public var followByMe : Int?
    public var postId : String?
    public var fName : String?
    public var lName : String?
    public var education : String?
    public var date : String?
    public var location : String?
    public var collectionName : String?
    public var collectionId : String?
    public var title : String?
    public var contentText : String?
    public var contentType : Int? // 1== text 2 == img 3==video 4== sound
    public var linkAddress : String? // linke marboot be marjaa
    public var likeCount : Int?
    public var likeByMe : Int? // man likesh kardam ya na
    public var imgSource:String?  // source ax
    public var additionalSource : String?
    public var ownerPic : String?
    public var allignment : String? // rtl or ltr
    public var owner_id : String?
    public var videoSource : String?
    
    
    init (){
        postId = ""
        fName = ""
        lName = ""
        education = ""
        date = ""
        location = ""
        collectionName = ""
        title = ""
        contentText = ""
        contentType = 1
        linkAddress = ""
        collectionId = ""
        likeCount  = 0
        likeByMe = 0
        imgSource = ""
        additionalSource = ""
        ownerPic = ""
        allignment = ""
        owner_id=""
        videoSource = ""
        followByMe = 0
    }
    
    
}
