//
//  ReportResp.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/6/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct ReportResp : Decodable {
    public var  clueId : String
    public var  reporterId : String
    public var  error : Int
    public var  errorMessage : String
}

