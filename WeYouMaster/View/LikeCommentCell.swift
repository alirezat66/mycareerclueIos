//
//  LikeComment.swift
//  WeYouMaster
//
//  Created by alireza on 8/29/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
class LikeCommentCell : UITableViewCell {
    @IBOutlet weak var btnLike : UIButton!
    @IBOutlet weak var lblTime : UILabel!
    @IBOutlet weak var imgLogo : UIButton!
    @IBOutlet weak var txtType : UILabel!
    @IBOutlet weak var lblTitle : UILabel!
    

    public func updateView(like : LikeFollow)  {
       
        if(like.type == 2){
            btnLike.backgroundColor = UIColor.blue
            let s = like.from;
            let s2 = " اکانت شما را دنبال کرد.";
            lblTitle.text = s + s2
            txtType.text = "رصد جدید"
            
        }else {
            btnLike.backgroundColor = UIColor.red
            let s = like.from;
            let s2 = " به ";
            let s3 = "مطلب شما ";
            let s4 = "علاقه نشان داد.";
            lblTitle.text = s + s2 + s3 + s4
              txtType.text = "علاقه جدید"
        }
        btnLike.layer.cornerRadius = btnLike.layer.frame.width/2
        btnLike.clipsToBounds = true
        lblTime.text = like.reg_time
        
        if(like.senderPic != "")
        {
            let url = URL(string : like.senderPic)
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgLogo.setBackgroundImage(image, for: .normal)
                        }
                    }
                }
            }
        }else{
            DispatchQueue.global().async { [weak self] in
               
                
                            self?.imgLogo.setBackgroundImage( UIImage.init(named: "avatar_icon"), for: .normal)
                    }
        }
        
        imgLogo.layer.cornerRadius = imgLogo.layer.frame.width/2
        imgLogo.clipsToBounds = true
        
        
        
        
    
    }
}
