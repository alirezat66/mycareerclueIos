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
    
    @IBOutlet weak var ButtomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var impPerson: UIButton!
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    var reciverId = String()
    var recieverName = String()
    var recieverImage = String()
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
            
            impPerson.layer.cornerRadius =
                impPerson.frame.size.width/2
            impPerson.clipsToBounds = true
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
        SVProgressHUD.show(withStatus: "Please Wait   ... \n\n")
       
        
        
        makeHeader();
        
      
        
        
        
        let helloWorldTimer = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(sayHello), userInfo: nil, repeats: true)
        
        helloWorldTimer.fire()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        

    }
    @IBOutlet weak var bottomText: NSLayoutConstraint!
    @objc func keyboardWillShow(notification:NSNotification)
    {
        if let info = notification.userInfo{
            let rect:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
                self.bottomText.constant = rect.height + 20
            })
        }
    }
    @objc func sayHello()
    {
        getChatList()
    }
    func makeHeader(){
        txtName.text = recieverName
        
        if(recieverImage != ""){
            
            let url = URL(string: recieverImage)
            
            
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            
                            
                            self?.impPerson.setImage(image, for: UIControlState.normal)
                            
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.impPerson.setImage(UIImage(named: "avatar_icon.png"), for: UIControlState.normal)
            }
        }
        
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
            
            if(self.messageList.count==0){
                for mess in (chatList.messages) {
                   
                        self.messageList.append(mess)
                    
                    
                    
                    
                }
            }else{
            for mess in (chatList.messages) {
                let contains = self.messageList.contains(where: { $0.message == mess.message && $0.senderId == mess.senderId })
                if(!contains){
                    self.messageList.insert(mess, at: 0)
                }

                
               
            }
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
