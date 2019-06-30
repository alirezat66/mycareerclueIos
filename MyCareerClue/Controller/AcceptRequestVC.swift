//
//  AcceptRequestVC.swift
//  WeYouMaster
//
//  Created by alireza on 6/9/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class AcceptRequestVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tvConversation: UITableView!
    var myConversation : [Conversation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        myConversation = []
        tvConversation.dataSource = self
        tvConversation.delegate = self
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        getConversation()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myConversation.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "reqcell") as? RequestedMessageCell {
            cell.updateView(conversation:myConversation[indexPath.row])
            cell.onAcceptTapped = {
                self.acceptMessage(conversation: self.myConversation[indexPath.row],index: indexPath.row)
            }
            cell.onDenyTapped = {
                self.denyMessage(conversation: self.myConversation[indexPath.row],index: indexPath.row)
            }
            cell.imgSender?.tag = indexPath.row
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            tapGestureRecognizer.numberOfTapsRequired = 1
            cell.imgSender?.isUserInteractionEnabled = true
            cell.imgSender?.addGestureRecognizer(tapGestureRecognizer)
            return cell
        }else {
            return ConversationCell()
        }
    }
    func acceptMessage(conversation : Conversation ,  index : Int){
       
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.acceptMessage(owner,conversation.displayId) {
            (NormalResp , error) in
            if let error  = error {
                print(error)
                self.updateError()
                return
            }
            guard let res = NormalResp else {
                print("error getting collections")
                self.updateError()
                return
            }
            if(res.error == 0 ){
                self.myConversation.remove(at: index)
                self.updateUI()
                if(self.myConversation.count == 0 ){
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                 self.updateError()
            }
           
        }
    }
    
    func updateUI(){
        DispatchQueue.main.async{
            self.tvConversation.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    func denyMessage(conversation : Conversation, index : Int) {
        
        
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.deleteMessage(owner,conversation.displayId) {
            (NormalResp , error) in
            if let error  = error {
                print(error)
                self.updateError()
                return
            }
            guard let res = NormalResp else {
                print("error getting collections")
                self.updateError()
                return
            }
            if(res.error == 0 ){
                self.myConversation.remove(at: index)
                self.updateUI()
                if(self.myConversation.count == 0 ){
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                self.updateError()
            }
            
        }
        
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
        let imgView = tapGestureRecognizer.view as! UIImageView
        let content = myConversation[imgView.tag]
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        profile.profileId = content.displayId
        profile.getOwner = owner
        profile.bio = ""
        self.present(profile, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let StoryBoard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC  = StoryBoard.instantiateViewController(withIdentifier:"ChatVC" ) as? ChatVC
        DVC?.reciverId = myConversation[indexPath.row].displayId
        DVC?.recieverName = myConversation[indexPath.row].displayName
        DVC?.recieverImage = myConversation[indexPath.row].displayPhoto
     //   self.present(DVC!,animated: true)
        //  self.navigationController?.pushViewController(DVC!, animated: true)
        
    }
    func getConversation() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getRequestedConversation(50,1,owner) {
            (ConversationResponse , error) in
            if let error  = error {
                print(error)
                self.updateError()
                return
            }
            guard let conversation = ConversationResponse else {
                print("error getting collections")
                self.updateError()
                return
            }
            for conv in (conversation.messages) {
                self.myConversation.append(conv)
            }
            self.updateUI(conv :conversation)
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(conv : RequestedResponse){
        DispatchQueue.main.async{
            self.tvConversation.reloadData()
            SVProgressHUD.dismiss()
        
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
