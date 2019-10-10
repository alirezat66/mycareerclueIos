//
//  ProfileImageUpdateObject.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/8/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct ProfileImageUpdateObject : Decodable {
  let  filename : String
  let  error : Int
  let  errorMessage : String
}
