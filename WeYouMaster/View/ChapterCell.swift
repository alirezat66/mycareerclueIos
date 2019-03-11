//
//  ChapterCell.swift
//  WeYouMaster
//
//  Created by alireza on 3/11/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class ChapterCell: UITableViewCell {

    
    @IBOutlet weak var lblChapter: UILabel!
    @IBOutlet weak var lyEdit: UIView!
    
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
    public func updateView(chapter : CollectionChapter,isOwner : Bool){
        if(isOwner){
            lyEdit.isHidden = false
        }else {
            lyEdit.isHidden = true
        }
        lblChapter.text = chapter.Collection_Title
       
        lblDetail.text = "از تاریخ " + chapter.Published_Date +  " شامل " +  String(chapter.collection_posts_number) + " پست"
        
        lblDesc.text = chapter.Collection_Description
        
        
        
    }
}
