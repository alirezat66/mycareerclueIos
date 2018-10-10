//
//  ConversationCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/23/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

    @IBOutlet weak var imgPerson: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblShortText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    func updateView(conversation : Conversation)  {
        let name =  conversation.fName + " " + conversation.lName
        lblName.text = name
        lblShortText.text = conversation.shortText
        lblTime.text = conversation.lblTime
        lblCount.text = conversation.count
        imgPerson.image = UIImage(named: conversation.imgSource)
        
        lblCount.layer.cornerRadius = lblCount.frame.size.width/2
        lblCount.clipsToBounds = true
        
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        
    }
    
}
