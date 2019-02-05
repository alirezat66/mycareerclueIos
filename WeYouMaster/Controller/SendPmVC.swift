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
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        sendMessage()
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
        txt_name.text = "ارسال پیام به " + last_name
       
        
        
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
           edt_text.text = "پیام خود را بنویسید"
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
