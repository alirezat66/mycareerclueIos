//
//  SaverResp.swift
//  WeYouMaster
//
//  Created by alireza on 6/8/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct SaverResp : Decodable {
    public var contributionId : String
    public var saver_id : String
    public var saver_name : String
    public var saver_lName : String
    public var saverDegree : String
    public var saver_image : String

}
