//
//  BackendError.swift
//  WeYouMaster
//
//  Created by alireza on 8/11/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
enum BackendError: Error {
    case urlError(reason: String)
    case objectSerialization(reason: String)
}
