//
//  SearchCell.swift
//  WeYouMaster
//
//  Created by alireza on 1/19/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {


    @IBOutlet weak var img: UIImageView!
    
   
    @IBOutlet weak var lbl: UILabel!
    
    public func updateView(search : SearchObj){
        lbl.text = search.text
        if(search.photo != ""){
            imageFromServerURL(urlString: search.photo)
        }
        if(search.type == "User"){
            img.layer.cornerRadius = img.frame.size.width/2
            img.clipsToBounds = true
        }
     //   lblText.text = search.text
        /*if(search.photo != ""){
            imageFromServerURL(urlString: search.photo)
        }
        */
    }
    
    func imageFromServerURL(urlString: String) {
       self.img.image = UIImage.init(named:"data_collection_img.png" )
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
    
    
    

}
