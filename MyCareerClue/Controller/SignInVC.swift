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
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBAction func btnReg(_ sender: Any) {
       
        signUp()
    }
    @IBAction func btnShowCondition(_ sender: Any) {
        let string = "https://mycareerclue.com/terms"
        guard let url = URL(string: string) else { return}
        UIApplication.shared.open(url)
    }
    func signUp() {
        if(!mySwitch.isOn){
            Utility.showToast(message: "Please accept condition and terms", myView: myView)
            return
        }
        if(edtName.text == "" || edtLName.text ==  "" || edtEmail.text == "" || edtPassword.text == "" ){
            Utility.showToast(message: "Please fill in all fields", myView: myView)
        }else{
             SVProgressHUD.show(withStatus: "  Please Wait ... \n\n")
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
                    self.goToHome(ownerId: contentList.ownerId,userkey: contentList.user_key)
                }else{
                    self.updateError()
                }
               
               
            }
        }
    }
    func goToHome(ownerId : String,userkey : String)  {
        DispatchQueue.main.async{
            let userDefaults = UserDefaults.standard
            userDefaults.set(ownerId, forKey: "owner")
            userDefaults.set(self.edtEmail.text!, forKey: "email")
            userDefaults.set(self.edtName.text!, forKey: "fName")
            userDefaults.set(self.edtJob.text!, forKey: "industry")
            userDefaults.set(self.edtCountry.text!, forKey: "City")
            userDefaults.set(self.edtJob.text!, forKey: "job")
            userDefaults.set(self.edtLName.text!, forKey: "lName")
            userDefaults.set(userkey, forKey: "user_key")
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
    
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var edtPhone : UITextField!
    @IBOutlet weak var edtCountry : UITextField!
    @IBOutlet weak var edtJob : UITextField!
    @IBOutlet weak var myView : UIView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()

    }
    func addDoneButtonOnKeyboard()
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.edtName.inputAccessoryView = doneToolbar
        self.edtLName.inputAccessoryView = doneToolbar
        self.edtEmail.inputAccessoryView = doneToolbar
        self.edtPhone.inputAccessoryView = doneToolbar
        self.edtCountry.inputAccessoryView = doneToolbar
        self.edtJob.inputAccessoryView = doneToolbar

        
    }
    @objc func doneButtonAction(){
        self.edtName.resignFirstResponder()
        self.edtLName.resignFirstResponder()
        self.edtEmail.resignFirstResponder()
        self.edtPhone.resignFirstResponder()
        self.edtCountry.resignFirstResponder()
        self.edtJob.resignFirstResponder()
    }
    func setborder(myTextField : UITextField ) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.frame.height, width: myTextField.frame.width-2, height: 2)
        bottomLine.backgroundColor = UIColor.white.cgColor
        myTextField.borderStyle = UITextBorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    
    }

    

    
   
}

