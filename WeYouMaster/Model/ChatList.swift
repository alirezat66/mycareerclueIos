//
//  ChatList.swift
//  WeYouMaster
//
//  Created by alireza on 1/13/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct ChatList  : Decodable{
    let messages :[Message];
    let errors : [errorMessage]
}
