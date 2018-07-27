//
//  Collection.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct  Collection {
    public var fName : String
    public var lName : String
    public var title : String
    public var price : String
    public var place : String
    public var numberOfPost : UInt
    public var img : String
    
    init(fName:String, lName: String,title : String ,
         price:String , place:String,
         numberOfPost:UInt,img : String){
        self.fName = fName
        self.lName = lName
        self.title = title
        self.price = price
        self.place = place
        self.numberOfPost = numberOfPost
        self.img = img
    }
    
}
