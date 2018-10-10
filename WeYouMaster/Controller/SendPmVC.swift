//
//  SendPmVC.swift
//  WeYouMaster
//
//  Created by alireza on 10/10/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class SendPmVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var imgPerson : UIImageView!
    @IBOutlet weak var txt_name : UILabel!
    @IBOutlet weak var edt_text : UITextView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if edt_text.textColor == UIColor.lightGray {
            edt_text.text = ""
            edt_text.textColor = UIColor.black
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        edt_text.text = "پیام خود را بنویسید"
        edt_text.textColor = UIColor.lightGray
        
       edt_text.delegate = self
        
        
        let userDefaults = UserDefaults.standard
        imgPerson.layer.cornerRadius = imgPerson.frame.width/2
        imgPerson.clipsToBounds = true
       let Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        
        let last_name = userDefaults.value(forKey: "lastname") as! String
        txt_name.text = last_name
        if(Profile_photo_link != ""){
            
            let url = URL(string: Profile_photo_link)
            
            
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            
                            
                            self?.imgPerson.image = image
                            
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
               
                self.imgPerson.image = UIImage(named: "avatar_icon.png")
            }
        }
        
        
        // Do any additional setup after loading the view.
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
