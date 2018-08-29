//
//  LikeComment.swift
//  WeYouMaster
//
//  Created by alireza on 8/29/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
class LikeCommentCell : UITableViewCell {
    @IBOutlet weak var btnSender : UIButton!
    @IBOutlet weak var btnFeed : UIButton!
    @IBOutlet weak var btnLike : UIButton!

    public func updateView(like : LikeFollow)  {
        btnLike.layer.cornerRadius = btnLike.layer.frame.width/2
        btnLike.clipsToBounds = true
        
        btnSender.setTitle(like.from, for: .normal)
        btnFeed.setTitle(like.feedTitle, for: .normal)
    }
}
