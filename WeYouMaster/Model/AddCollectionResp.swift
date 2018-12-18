//
//  AddCollectionResp.swift
//  WeYouMaster
//
//  Created by alireza on 12/3/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct AddCollectionResp : Decodable {
    let error : Int
    let errorMessage : String
    let collectionId : String
}
