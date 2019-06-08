//
//  SaverCell.swift
//  WeYouMaster
//
//  Created by alireza on 6/8/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class SaverCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    public func updateView(search : SaverResp){
        lbl.text = search.saver_name + " " + search.saver_lName
        if(search.saver_image != ""){
            imageFromServerURL(urlString: search.saver_image)
        }
        img.layer.cornerRadius = img.frame.size.width/2
        img.clipsToBounds = true
       
    }
    func imageFromServerURL(urlString: String) {
        self.img.image = UIImage.init(named:"avatar_icon.png" )
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                
                return
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.img.image = image
            })
            
        }).resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
