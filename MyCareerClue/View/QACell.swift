//
//  QACell.swift
//  WeYouMaster
//
//  Created by alireza on 8/28/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class QACell: UITableViewCell {

   @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    public func updateView (qa : QA){
        lblTitle.text = qa.title
        lblDescription.text = qa.description
    }

}
