//
//  otherContact.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct OtherContent : Decodable {
    public var error : Int
    public var errorMessage : String
    public var  postId : String
    public var fName : String
    public var lName : String
    public var education : String
    public var date : String
    public var location : String
    public var collectionName : String
    public var title : String
    public var contentText : String
    public var contentType : Int
    public var linkAddress : String
    public var likeCount : Int
    public var  likeByMe : Int
    public var imgSource : String
    public var additionalSource : String
    
    
    init (){
        error = 0
        errorMessage = ""
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
        likeCount  = 0
        likeByMe = 0
        imgSource = ""
        additionalSource = ""
    }
}
