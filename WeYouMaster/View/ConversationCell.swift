//
//  ConversationCell.swift
//  WeYouMaster
//
//  Created by alireza on 7/23/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ConversationCell: UITableViewCell {

    
    @IBOutlet weak var imgPerson: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblShortText: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    
    func updateView(conversation : Conversation)  {
        let name =  conversation.displayName
        lblName.text = name
        lblShortText.text = conversation.lastMessage.content
        if(conversation.lastMessage.content.count>15){
            let index = conversation.lastMessage.content.index(conversation.lastMessage.content.startIndex, offsetBy: 15)

            let short = conversation.lastMessage.content.substring(to: index)
             lblShortText.text = short
        }else{
            let short = conversation.lastMessage.content
            lblShortText.text = short
            
        }
    
        lblTime.text = conversation.lastMessage.timestamp
        lblCount.text = String( conversation.unReadedMessage)
       
        
        lblCount.layer.cornerRadius = lblCount.frame.size.width/2
        lblCount.clipsToBounds = true
        if(conversation.unReadedMessage == 0){
            lblCount.isHidden = true
        }else{
            lblCount.isHidden = false
        }
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        let url = URL(string : conversation.displayPhoto)
        self.imgPerson.setBackgroundImage(UIImage(named: "avatar_icon.png") , for: .normal)
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imgPerson.setBackgroundImage(image, for: .normal)
                    
                        self?.imgPerson.layoutIfNeeded()
                        self?.imgPerson.subviews.first?.contentMode = .scaleAspectFill
                        
                    }
                }
            }
        }
        
    }
    
}
