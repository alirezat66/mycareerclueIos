//
//  FollowCommentTableViewCell.swift
//  WeYouMaster
//
//  Created by alireza on 8/29/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class FollowCommentCell: UITableViewCell {

    @IBOutlet weak var btnSender : UIButton!
    @IBOutlet weak var btnFollow : UIButton!
    
    public func updateView(like : LikeFollow)  {
        btnFollow.layer.cornerRadius = btnFollow.layer.frame.width/2
        btnFollow.clipsToBounds = true
        btnSender.setTitle(like.from, for: .normal)
    }

}
