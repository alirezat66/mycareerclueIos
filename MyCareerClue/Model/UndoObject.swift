//
//  UndoObject.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct UndoObject : Decodable {
    let total_reported_clues : Int
    let clueId : String
    let reporterId : String
    let error : Int
    let errorMessage : String
}
