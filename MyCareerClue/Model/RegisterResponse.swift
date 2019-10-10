//
//  RegisterRespomse.swift
//  WeYouMaster
//
//  Created by alireza on 9/14/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct RegisterResponse : Decodable{
    let error : Int
    let errorMessage : String
    let ownerId : String
    let user_key : String
}
