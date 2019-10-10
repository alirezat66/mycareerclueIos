//
//  SendPmVC.swift
//  WeYouMaster
//
//  Created by alireza on 10/10/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class SendPmVC: UIViewController,UITextViewDelegate {

    @IBOutlet weak var txt_name : UILabel!
    @IBOutlet weak var edt_text : UITextView!
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion:nil)
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
        
        self.edt_text.inputAccessoryView = doneToolbar
        
        
    }
    @objc func doneButtonAction(){
        self.edt_text.resignFirstResponder()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBOutlet weak var btnCancelOut: UIButton!
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var btnSendOut: UIButton!
    @IBAction func btnSend(_ sender: Any) {
        let str = edt_text.text
        let trimed = str?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(trimed == ""){
                let emptyAlart = UIAlertController(title: "Info", message: "You Can Not Send Empty Message", preferredStyle: UIAlertControllerStyle.alert)
                emptyAlart.addAction(UIAlertAction(title: "Understand", style: .default, handler: nil))
                present(emptyAlart,animated: true,completion: nil)
        }else {
            SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
            sendMessage()
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if edt_text.textColor == UIColor.lightGray {
            edt_text.text = ""
            edt_text.textColor = UIColor.black
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        edt_text.text = "Write Your Message"
        edt_text.textColor = UIColor.lightGray
        edt_text.delegate = self
        
        btnSendOut.layer.cornerRadius = 2
        btnSendOut.layer.borderWidth = 1
        btnSendOut.layer.borderColor = UIColor.black.cgColor
        
        edt_text.layer.borderWidth = 1
        edt_text.layer.borderColor = UIColor.orange.cgColor
        
        
        btnCancelOut.backgroundColor = .clear
        btnCancelOut.layer.cornerRadius = 2
        btnCancelOut.layer.borderWidth = 1
        btnCancelOut.layer.borderColor = UIColor.orange.cgColor
        let userDefaults = UserDefaults.standard
       
        
        let last_name = userDefaults.value(forKey: "lastname") as! String
        txt_name.text = "Send Message To " + last_name
       
        
        
        // Do any additional setup after loading the view.
    }
    
    private func textViewDidBeginEditing(textView: UITextView) {
        if edt_text.textColor == UIColor.lightGray {
            edt_text.text = nil
            edt_text.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if edt_text.text.isEmpty {
           edt_text.text = "Write Your Message"
            edt_text.textColor = UIColor.lightGray
        }
    }
    
    func sendMessage (){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        let reciver = userDefaults.value(forKey: "lastId") as! String

        let message = Message(senderName: "", receverName: "", message: edt_text.text!, senderId: owner, sendedTime: "")
        WebCaller.sendMessage(message.message,owner,reciver) {
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
                 DispatchQueue.main.async{
                     SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
                }
            }
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
        }
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var buttomConstraint: NSLayoutConstraint!
  
}