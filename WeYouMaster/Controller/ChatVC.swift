//
//  ChatVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
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
        messageList.append(message)
        print(String(messageList.count))
        chatTable.reloadData()
    }
    @IBAction func btnSendPush(_ sender: Any) {
        if(isActive){
            let _message  = Message(mid: "asd", user: User(id: "1", name: "ali", avatar: "myImage.jpg", online: true), content: edtChat.text!, date: "", type: 1)
            addChat(message: _message)
            edtChat.text=""
            isActive=false
            
            
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    @IBOutlet weak var edtChat: UITextField!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  message : Message = messageList[indexPath.row]
       
        
        if(message.user.id=="1"){
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
        messageList = DataService.instance.getMessages()
        chatTable.delegate = self
        chatTable.dataSource = self


    }
    
    

  

}
