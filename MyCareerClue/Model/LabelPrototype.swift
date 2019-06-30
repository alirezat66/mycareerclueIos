//
//  LabelPrototype.swift
//  WeYouMaster
//
//  Created by alireza on 12/3/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct LabelPrototype : Codable {
    
    var type : String
    var title : String
    init(type : String , title : String){
        self.type = type
        self.title = title
    }
}
