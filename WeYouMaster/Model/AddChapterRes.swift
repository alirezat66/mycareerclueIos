//
//  AddChapterRes.swift
//  WeYouMaster
//
//  Created by alireza on 12/5/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct AddChapterRes : Decodable {
    let error : Int
    let errorMessage : String
    let chapterId : String
}
