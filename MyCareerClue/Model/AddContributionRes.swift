//
//  AddContributionRes.swift
//  WeYouMaster
//
//  Created by alireza on 12/6/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct AddContributionRes :Decodable{
    let error : Int
    let errorMessage : String
    let contributionId : String
}
