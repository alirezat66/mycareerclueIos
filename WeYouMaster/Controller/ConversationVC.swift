//
//  ConversationVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class ConversationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var myConversation : [Conversation] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myConversation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell") as? ConversationCell {
            cell.updateView(conversation:myConversation[indexPath.row])
            return cell
        }else {
            return ConversationCell()
        }
    }
    

    @IBOutlet weak var lyNew: UIButton!
    @IBOutlet weak var tvConversation: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myConversation = []
        tvConversation.dataSource = self
        tvConversation.delegate = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getConversation()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let StoryBoard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC  = StoryBoard.instantiateViewController(withIdentifier:"ChatVC" ) as? ChatVC
        DVC?.reciverId = myConversation[indexPath.row].displayId
        self.present(DVC!,animated: true)
      //  self.navigationController?.pushViewController(DVC!, animated: true)
        
    }
    func getConversation() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getConversation(50,1,owner) {
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
    func updateUI(conv : ConversationResponse){
        DispatchQueue.main.async{
            self.tvConversation.reloadData()
            SVProgressHUD.dismiss()
            if(conv.allRequestedMessageNumber==0){
                self.lyNew.isHidden = true
                self.tvConversation.layoutIfNeeded()
            }else{
                self.lyNew.isHidden = false
            }
        
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }

   

}
