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

   @IBOutlet weak var tableView : UITableView!
    var myLikes : [LikeFollow] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getLikes()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLikes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let  comment : LikeFollow = myLikes[indexPath.row]
        
        
        if(comment.type==1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LikeCommentCell
            cell.updateView(like: comment)
            return cell
            
        }else if (comment.type==2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! FollowCommentCell
            cell.updateView(like: comment)
            return cell
            
        }else{
            let cell  = UITableViewCell()
            return cell
        }
    }
  
    func getLikes(){
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let owner = userDefaults.value(forKey: "owner") as! String
        
        
        WebCaller.getLikes(20, 1,owner) { (likeList, error) in
            if let error = error{
                print(error)
                return
            }
            guard let likes = likeList else{
                print("error getting collections")
                return
            }
            for like in (likes.records) {
                self.myLikes.append(like)
            }
            self.updateUI()
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
}
