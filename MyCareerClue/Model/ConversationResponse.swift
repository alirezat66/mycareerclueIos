//
//  ConversationResponse.swift
//  WeYouMaster
//
//  Created by alireza on 1/13/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import Foundation
struct ConversationResponse : Decodable{
    let messages :[Conversation];
    let errorMessage : errorMessage
    let allRequestedMessageNumber : Int ;
}
