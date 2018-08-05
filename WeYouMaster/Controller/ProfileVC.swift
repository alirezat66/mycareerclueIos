//
//  ProfileVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/5/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    public var phoneNumber = ""
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtLName: UITextField!
    @IBOutlet weak var edtEmail: UITextField!
    @IBAction func btnCancel(_ sender: Any) {
    }
    @IBAction func btnSave(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNumber.text = phoneNumber
        imgProfile.image  = UIImage.init(named: "add_user_pn.png")
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

   
}
