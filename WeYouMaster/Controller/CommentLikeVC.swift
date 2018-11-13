//
//  CommentLikeVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/29/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class CommentLikeVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var imgNot1: UIButton!
    @IBOutlet weak var imgNot2: UIButton!
    @IBOutlet weak var imgNot3: UIButton!
    @IBOutlet weak var imgNot4: UIButton!
    @IBOutlet weak var imgNot5: UIButton!
    @IBOutlet weak var imgNot6: UIButton!
    @IBOutlet weak var imgNot7: UIButton!
    @IBOutlet weak var imgNot8: UIButton!
    @IBOutlet weak var imgNot9: UIButton!
    
    @IBOutlet weak var imgProfile: UIButton!
    

   @IBOutlet weak var tableView : UITableView!
    var myLikes : [LikeFollow] = []
    var refreshControll : UIRefreshControl?
    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        tableView.addSubview(refreshControll!)
    }
    @objc func refreshList(){
        myLikes = []
        getLikes()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        addRefreshControl()
        
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.width/2
        imgProfile.clipsToBounds = true

    }
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        myLikes = []
        updateUI()
        tableView.delegate = self
        tableView.dataSource = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getLikes()
        makeButtonCirc(obj: imgNot1)
        makeButtonCirc(obj: imgNot2)
        makeButtonCirc(obj: imgNot3)
        makeButtonCirc(obj: imgNot4)
        makeButtonCirc(obj: imgNot5)
        makeButtonCirc(obj: imgNot6)
        makeButtonCirc(obj: imgNot7)
        makeButtonCirc(obj: imgNot8)
        makeButtonCirc(obj: imgNot9)
        
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
        
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLikes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if(myLikes.count >= indexPath.row){
        let  comment : LikeFollow = myLikes[indexPath.row]
        
            if(comment.type == 1 || comment.type == 2){
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LikeCommentCell
            cell.updateView(like: comment)
                cell.onButtonTapped = {
                    self.openProfile(like : comment)
                }
            return cell
            }else{
            let cell  = UITableViewCell()
            return cell
                
        }
        }else{
            let cell  = UITableViewCell()
            return cell
        }
        
    }
        
    func openProfile(like:LikeFollow) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        profile.getName = like.from
        profile.getCity = ""
        profile.getRole = ""
        
        
        profile.getImage = like.senderPic
        profile.followedByMe = like.followByMe
        profile.profileId = like.fromId
        profile.getOwner = owner
        profile.bio = ""
        self.present(profile, animated: true, completion: nil)
        
    }
  
    func getLikes(){
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let owner = userDefaults.value(forKey: "owner") as! String
        
        
        WebCaller.getLikes(20, 1,owner) { (likeList, error) in
            if let error = error{
                print(error)
                self.updateError()
                return
            }
            guard let likes = likeList else{
                print("error getting collections")
                self.updateError()
                return
            }
            for like in (likes.records) {
                self.myLikes.append(like)
            }
            self.updateUI()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()

            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
}
