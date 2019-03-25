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
    @IBOutlet weak var imgNot1: UIButton!
    @IBOutlet weak var imgNot2: UIButton!
    @IBOutlet weak var imgNot3: UIButton!
    @IBOutlet weak var imgNot4: UIButton!
    @IBOutlet weak var imgNot5: UIButton!
    @IBOutlet weak var imgNot6: UIButton!
    @IBOutlet weak var imgNot7: UIButton!
    @IBOutlet weak var imgNot8: UIButton!
    @IBOutlet weak var imgNot9: UIButton!
    
    
    @IBOutlet var notifClick: [UIStackView]!
    @IBOutlet weak var imgProfile: UIButton!
    @IBAction func menuClick(_ sender: Any) {
    }
    @IBAction func personImageClick(_ sender: Any) {
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ConversationCell") as? ConversationCell {
            cell.updateView(conversation:myConversation[indexPath.row])
            return cell
        }else {
            return ConversationCell()
        }
    }
    @objc func notifTap() {
        // present modally
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "likeOthers") as! CommentLikeOtherVC
        self.present(detail, animated: true, completion: nil)
    }
    
    @IBOutlet weak var stackNotif: UIStackView!

    @IBOutlet weak var lyNew: UIButton!
    @IBOutlet weak var tvConversation: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myConversation = []
        tvConversation.dataSource = self
        tvConversation.delegate = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getConversation()
        
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.width/2
        imgProfile.clipsToBounds = true
        makeButtonCirc(obj: imgNot1)
        makeButtonCirc(obj: imgNot2)
        makeButtonCirc(obj: imgNot3)
        makeButtonCirc(obj: imgNot4)
        makeButtonCirc(obj: imgNot5)
        makeButtonCirc(obj: imgNot6)
        makeButtonCirc(obj: imgNot7)
        makeButtonCirc(obj: imgNot8)
        makeButtonCirc(obj: imgNot9)
        let singleTap = UITapGestureRecognizer(target: self,action:#selector(ConversationVC.notifTap))
        
        stackNotif.isUserInteractionEnabled = true
        stackNotif.addGestureRecognizer(singleTap)
        let userDefaults = UserDefaults.standard
        
        let Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        if(Profile_photo_link != ""){
            
            let url = URL(string: Profile_photo_link)
            
            
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            
                            
                            self?.imgProfile.setImage(image, for: UIControlState.normal)
                            
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.imgProfile.setImage(UIImage(named: "avatar_icon.png"), for: UIControlState.normal)
            }
        }
        
        // Do any additional setup after loading the view.
    }
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let StoryBoard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC  = StoryBoard.instantiateViewController(withIdentifier:"ChatVC" ) as? ChatVC
        DVC?.reciverId = myConversation[indexPath.row].displayId
        DVC?.recieverName = myConversation[indexPath.row].displayName
        DVC?.recieverImage = myConversation[indexPath.row].displayPhoto
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
