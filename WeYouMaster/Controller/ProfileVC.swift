//
//  ProfileVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/5/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import JJFloatingActionButton
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
        if ( (edtName.text?.count)!>0){
            if((edtLName.text?.count)!>0){
                if((edtEmail.text?.count)!>0){
                    let name  = edtName.text
                    let lName = edtLName.text
                    let email = edtEmail.text
                    let usD = UserDefaults.standard
                    usD.set(2, forKey: "loginState")
                    usD.set(name, forKey: "name")
                    usD.set(lName,forKey: "lName")
                    usD.set(email, forKey: "email")
                    
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let stepOne = storyBoard.instantiateViewController(withIdentifier: "stepOne") as! StepOneVC
                    
                    self.present(stepOne, animated: true, completion: nil)
                }else{
                    Utility.showToast(message: "ایمیل معتبر نیست", myView: self.view)
                }
            }else{
                Utility.showToast(message: "نام خانوادگی نباید خالی باشد.", myView: self.view)
            }
        }else{
            Utility.showToast(message: "نام نباید خالی باشد.", myView: self.view)
        }
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
