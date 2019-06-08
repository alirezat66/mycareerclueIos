//
//  RequestedMessageCell.swift
//  WeYouMaster
//
//  Created by alireza on 6/9/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class RequestedMessageCell: UITableViewCell {

    var onDenyTapped : (() -> Void)? = nil
    var onAcceptTapped : (() -> Void)? = nil
    
    @IBAction func btnDeny(_ sender: Any) {
        if let onDenyTapped = self.onDenyTapped {
            onDenyTapped()
        }
    }
    @IBAction func btnAccept(_ sender: Any) {
        if let onAcceptTapped = self.onAcceptTapped {
            onAcceptTapped()
        }
    }
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblUser: UILabel!
    @IBOutlet weak var imgSender: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func updateView(conversation : Conversation)  {
        lblUser.text = conversation.displayName
        lblMessage.text = conversation.lastMessage.content
        imgSender.layer.cornerRadius = imgSender.frame.size.width/2
        imgSender.clipsToBounds = true
        
       
        imageFromServerURL(urlString: conversation.displayPhoto)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func imageFromServerURL(urlString: String) {
        self.imgSender.image = UIImage.init(named:"avatar_icon.png" )
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                
                return
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imgSender.image = image
            })
            
        }).resume()
    }
}
