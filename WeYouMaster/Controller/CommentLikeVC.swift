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

    }
    override func viewDidAppear(_ animated: Bool) {
        myLikes = []
        updateUI()
        tableView.delegate = self
        tableView.dataSource = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getLikes()

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
