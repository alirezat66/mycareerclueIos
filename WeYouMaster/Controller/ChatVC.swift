//
//  ChatVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReverseExtension
class ChatVC: UIViewController,UITableViewDelegate , UITableViewDataSource {
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    var reciverId = String()
    var isActive = false
    @IBOutlet weak var sendButton: UIButton!
    @IBAction func edtChatChanged(_ sender: UITextField) {
        if edtChat.text == "" {
            if let image = UIImage(named: "sendButtonDisable.png") {
                sendButton.setImage(image, for: .normal)
                isActive = false
            }
        }else{
            if let image = UIImage(named: "sendButton.png") {
                sendButton.setImage(image, for: .normal)
                isActive = true
            }
            
        }
    }
    
    func addChat (message : Message){
        DispatchQueue.main.async{
        self.messageList.insert(message, at: 0)
        self.chatTable.reloadData()
        }
        
        
    }
    @IBAction func btnSendPush(_ sender: Any) {
        if(isActive){
            
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            let message = Message(senderName: "", receverName: "", message: edtChat.text!, senderId: owner, sendedTime: "")
            
            
            addChat(message: message)
            edtChat.text = ""
            isActive = false;
            
            
            WebCaller.sendMessage(message.message,owner,reciverId) {
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
                if(errorMessage.error != 0){
                    
                }
               
            }
            
     //       goToLast()
            
            
            /*let _message  = Message(mid: "asd", user: User(id: "1", name: "ali", avatar: "myImage.jpg", online: true), content: edtChat.text!, date: "", type: 1)
            addChat(message: _message)
            edtChat.text=""
            isActive=false
            */
            
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBOutlet weak var edtChat: UITextField!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  message : Message = messageList[indexPath.row]
       
        
        if(message.senderId==reciverId){
           let call = tableView.dequeueReusableCell(withIdentifier: "OutPutCell") as! OutPutTextCell
                call.updateView(message : message)
                return call
           
        }else{
            let call = tableView.dequeueReusableCell(withIdentifier: "InPutCell") as! InputTextCell
                call.updateView(message : message)
                return call
            
        }
    }
    
   /* func textFieldDidChange(edtChat: UITextView) {
        
        
     
    }*/
    
    @IBOutlet weak var chatTable: UITableView!
    var messageList  : [Message] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTable.re.delegate = self
        chatTable.dataSource = self
        chatTable.re.scrollViewDidReachTop = { scrollView in
            print("scrollViewDidReachTop")
        }
        chatTable.re.scrollViewDidReachBottom = { scrollView in
            print("scrollViewDidReachBottom")
        }
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getChatList()

    }
    func getChatList() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getChatList(50,1,owner,reciverId) {
            (ChatList , error) in
            if let error  = error {
                print(error)
                self.updateError()
                return
            }
            guard let chatList = ChatList else {
                print("error getting collections")
                self.updateError()
                return
            }
            for mess in (chatList.messages) {
                self.messageList.append(mess)
            }
            self.updateUI()
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
            self.chatTable.reloadData()
            
          //  self.goToLast()
           
            SVProgressHUD.dismiss()
            
        }
    }
    func goToLast() {
        let lastSectionIndex = self.chatTable.numberOfSections - 1 // last section
        let lastRowIndex = self.chatTable.numberOfRows(inSection: lastSectionIndex) - 1 // last row
        self.chatTable.scrollToRow(at: IndexPath(row: lastRowIndex, section: lastSectionIndex), at: UITableViewScrollPosition.bottom, animated: false)
    }
    
    

  

}
