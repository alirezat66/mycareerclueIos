//
//  LoginResponse.swift
//  WeYouMaster
//
//  Created by alireza on 8/11/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
struct LoginResponse: Codable  {

    let Owner: String
    let First_Name: String
    let Last_Name: String
    let Industry : String
    let Job_Position : String
    let City : String
    let Email : String
    let bio : String
    let LinkedIn : String
    let Website : String
    let Sold_sofar : String
    let Profile_photo_link : String
    let total_contributions : Int
    let  planStatus  : Int


    init?(json: [String: Any]) {
        guard let Owner = json["Owner"] as? String,
            let First_Name = json["First_Name"] as? String,
            let Last_Name = json["Last_Name"] as? String,
            let Industry = json["Industry"] as? String,
            let Job_Position = json["Job_Position"] as? String ,
            let City = json["City"] as? String ,
            let Email = json["Email"] as? String,
            let bio = json["bio"] as? String ,
            let LinkedIn = json["LinkedIn"] as? String,
            let Website = json["Website"] as? String ,
            let Sold_sofar = json["Sold_sofar"] as? String ,
            let Profile_photo_link = json["Profile_photo_link"] as? String ,
            let total_contributions = json["total_contributions"] as? Int,
            let planStatus = json["planStatus"] as? Int
      else {
                return nil
        }
        self.Owner = Owner
        self.First_Name = First_Name
        self.Last_Name = Last_Name
        self.Industry = Industry
        self.Job_Position = Job_Position
        self.City = City
        self.bio = bio
        self.Email = Email
        
        self.Profile_photo_link = Profile_photo_link
        self.total_contributions = total_contributions
        self.Website = Website
        self.Sold_sofar = Sold_sofar
        self.LinkedIn = LinkedIn
        self.planStatus = planStatus
    }
   
   
}


