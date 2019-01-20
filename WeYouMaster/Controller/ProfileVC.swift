//
//  ProfileVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/5/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import SVProgressHUD

extension UIViewController {
  
    
}
class ProfileVC: UIViewController,UITextFieldDelegate {
    
    
    
    @IBOutlet weak var txtAboat: UITextView!
    
    @IBAction func btnEdit(_ sender: Any) {
        editProfile()
    }
    @IBOutlet weak var imgPerson: UIImageView!
    
    @IBOutlet weak var edtLName: UITextField!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtRole: UITextField!
    @IBOutlet weak var edtLocation: UITextField!
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    var getName = String()
    var getLName = String()

    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var getOwner = String()
    var bio = String()
    
   
    @objc public func DismissKeyboard(){
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let tab : UITapGestureRecognizer = UITapGestureRecognizer(target : self , action : #selector(DismissKeyboard))
        view.addGestureRecognizer(tab)
        edtName.layer.borderColor  = UIColor.orange.cgColor
        edtLName.layer.borderColor = UIColor.orange.cgColor
        edtRole.layer.borderColor = UIColor.orange.cgColor
        edtLocation.layer.borderColor  = UIColor.orange.cgColor
        txtAboat.layer.borderColor = UIColor.orange.cgColor
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        
        edtName.text = getName
        edtLName.text = getLName
        edtRole.text = getRole
        edtLocation.text = getCity
        txtAboat.text = bio
        imageFromServerURL(urlString: getImage)
        
        
       /* lblNumber.text = phoneNumber
        imgProfile.image  = UIImage.init(named: "add_user_pn.png")
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true*/
       
        
        
        
        
        
     

        // Do any additional setup after loading the view.
    }

    func imageFromServerURL(urlString: String) {
        self.imgPerson.image = UIImage.init(named:"data_collection_img.png" )
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                
                return
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imgPerson.image = image
            })
            
        }).resume()
    }
    
    
    func editProfile(){
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        WebCaller.editProfile(getOwner,edtName.text!,edtLName.text!,edtRole.text!,edtLocation.text!,txtAboat.text!) {
            (errorMessage , error) in
            if let error  = error {
                print(error)
                self.updateError()
                return
            }
            guard let errorMessage = errorMessage else {
                print("error getting collections")
                self.updateError()
                return
            }
            if(errorMessage.error == 0){
                self.updateUI()
            }   else{
                self.updateError()
            }
            
        }
    }
    
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(){
        
        
        
        
        
        DispatchQueue.main.async{
        
            
            //  self.goToLast()
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.getOwner, forKey: "owner")
            userDefaults.set(self.edtName.text!, forKey: "fName")
            userDefaults.set(self.edtRole.text!, forKey: "industry")
            userDefaults.set(self.edtLocation.text!, forKey: "City")
            userDefaults.set(self.edtRole.text!, forKey: "job")
            userDefaults.set(self.edtLName.text!, forKey: "lName")
            userDefaults.set(self.txtAboat.text!, forKey: "bio")
            SVProgressHUD.dismiss()
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    @IBOutlet weak var bottomText: NSLayoutConstraint!

   
}
