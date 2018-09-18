//
//  ViewController.swift
//  WeYouMaster
//
//  Created by alireza on 7/16/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
class SignInVC: UIViewController {

    @IBAction func btnReg(_ sender: Any) {
       
        signUp()
    }
    func signUp() {
        
        if(edtName.text == "" || edtLName.text ==  "" || edtEmail.text == "" || edtPassword.text == "" ){
            Utility.showToast(message: "فیلدهای اجباری را پر کنید.", myView: myView)
        }else{
             SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
            WebCaller.signIn(edtName.text!, edtLName.text!, edtPhone.text!, edtEmail.text!, edtJob.text!, edtPassword.text!, edtCountry.text!
            ){
                
                (contents, error) in
                if let error = error{
                    self.updateError()
                    print(error)
                    return
                }
                guard let contentList = contents else{
                    self.updateError()
                    print("error getting collections")
                    return
                }
                if (contentList.error == 0 ){
                    self.goToHome(ownerId: contentList.ownerId)
                }else{
                    self.updateError()
                }
               
               
            }
        }
    }
    func goToHome(ownerId : String)  {
        DispatchQueue.main.async{
            let userDefaults = UserDefaults.standard
            userDefaults.set(ownerId, forKey: "owner")
            userDefaults.set(self.edtEmail.text!, forKey: "email")
            userDefaults.set(self.edtName.text!, forKey: "fName")
            userDefaults.set(self.edtJob.text!, forKey: "industry")
            userDefaults.set(self.edtCountry.text!, forKey: "City")
            userDefaults.set(self.edtJob.text!, forKey: "job")
            userDefaults.set(self.edtLName.text!, forKey: "lName")
            userDefaults.set("", forKey: "profilePhoto")
            userDefaults.set(0, forKey: "totalPost")
            userDefaults.set("", forKey: "webSite")
            userDefaults.set("", forKey: "bio")
            userDefaults.set("", forKey: "sales")
            userDefaults.set("" ,forKey : "linkedIn")
            userDefaults.set(3, forKey: "loginState")
            let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
            let home = StoryBoard.instantiateViewController(withIdentifier: "BaseBar" ) as? BaseTabBarController
            print("3")
            SVProgressHUD.dismiss()
            self.present(home!, animated: true, completion: nil)

        }
       
       
    }
    func updateError()  {
         DispatchQueue.main.async{
        SVProgressHUD.dismiss()
        }
    }
    @IBOutlet weak var edtName : UITextField!
    @IBOutlet weak var edtLName : UITextField!

    @IBOutlet weak var edtEmail : UITextField!

    @IBOutlet weak var edtPassword : UITextField!
    
    @IBOutlet weak var edtPhone : UITextField!
    @IBOutlet weak var edtCountry : UITextField!
    @IBOutlet weak var edtJob : UITextField!
    @IBOutlet weak var myView : UIView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        setborder(myTextField: edtName)
        setborder(myTextField: edtLName)
        setborder(myTextField: edtEmail)
        setborder(myTextField: edtPassword)
        setborder(myTextField: edtPhone)
        setborder(myTextField: edtCountry)
        setborder(myTextField: edtJob)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setborder(myTextField : UITextField ) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.frame.height, width: myTextField.frame.width-2, height: 2)
      
        bottomLine.backgroundColor = UIColor.white.cgColor
        myTextField.borderStyle = UITextBorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    
    }

    

    
   
}

