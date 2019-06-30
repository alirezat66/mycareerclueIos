//
//  CommentLikeOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip

class CommentLikeOtherVC: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
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
    
   
    @IBOutlet weak var tableView : UITableView!
    var myLikes : [LikeFollow] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        myLikes = []
        tableView.delegate = self
        tableView.dataSource = self
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
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
        let owner = userDefaults.value(forKey: "otherUser") as! String
        
        
        WebCaller.getLikes(20, 1,owner) { (likeList, error) in
            if let error = error{
                print(error)
                self.updateError()
                return
            }
            guard let likes = likeList else{
                self.updateError()
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
            self.refreshControll?.endRefreshing()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            self.refreshControll?.endRefreshing()
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }

}
