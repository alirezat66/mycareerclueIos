//
//  ProfileOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ProfileOtherVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var btnFollowOutlet: UIButton!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var loader : UIActivityIndicatorView!
    var getName = String()
    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func followPressed(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = getName
        lblLocation.text = getCity
        lblRole.text = getRole
        
        profileImage.layer.cornerRadius = profileImage.layer.frame.size.width/2
        profileImage.clipsToBounds = true
        let url = URL(string : getImage)
        loader.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                self?.loader.startAnimating()
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.profileImage.image = image
                        self?.loader.stopAnimating()
                        
                    }
                }
            }
        }
        
    }

}
