//
//  FollowingCollectionVC.swift
//  WeYouMaster
//
//  Created by alireza on 6/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class FollowingCollectionVC: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    var refreshControll : UIRefreshControl?
    var firstTime = true
    var myCollections : [FollowingResponseRecords] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollections = []
        
        updateUI()
        
        collectionTV.dataSource = self
        collectionTV.delegate = self
        
        SVProgressHUD.show(withStatus: "  Please Wait ... \n\n")
        getCloolections()
        addRefreshControl()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(myCollections.count == 0){
            if(!firstTime){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Collections will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myCollections.count
    }
    
    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        collectionTV.addSubview(refreshControll!)
    }
    @objc func refreshList(){
        
        myCollections = []
        getCloolections()
    }
    func getCloolections(){
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getFollowerList(viewer_id: owner) { (collections , error) in
            if let error = error{
                
                self.updateError()
                print(error)
                return
            }
            guard let collections = collections else{
                self.updateError()
                print("error getting collections")
                return
            }
            
            
            for collect in collections.records{
                self.myCollections.append(collect)
            }
            self.updateUI()
            
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = myCollections[indexPath.row]
        let userDefaults = UserDefaults.standard
        userDefaults.set(selectedRow.owner_id, forKey: "otherUser")
        let name = selectedRow.fName + " " + selectedRow.lName
        openDetail(degree: selectedRow.education, name: name, title: selectedRow.title, image: selectedRow.ownerPic,collectionId: selectedRow.collectionId,numOfPost: 0,startDate: selectedRow.date)
    }
    func updateError(){
        DispatchQueue.main.async{
            self.firstTime = false
            self.collectionTV.reloadData()
            self.refreshControll?.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.firstTime = false
            self.collectionTV.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    public func openDetail(degree : String , name : String ,title : String , image : String ,collectionId : String , numOfPost : Int,startDate : String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "collectionDetail") as! CollectionDetailTwoVC
        
        detail.getDegree = degree
        detail.getName = name
        detail.getTitle = title
        detail.getImage = image
        detail.collectionId = collectionId
        detail.numberOdPost = numOfPost
        detail.getStartDate = startDate
        self.present(detail, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as? CollectionCell{
            let collection = myCollections[indexPath.row]
            cell.updateView(collection:collection)
            cell.onButtonTapped = {
                self.openProfile(collection : collection)
            }
            cell.onButtonTappedOnShow = {
                let userDefaults = UserDefaults.standard
                userDefaults.set(collection.owner_id, forKey: "otherUser")
                let name = collection.fName + " " + collection.lName
                self.openDetail(degree: collection.education, name: name, title: collection.title, image: collection.ownerPic,collectionId: collection.collectionId,numOfPost: 0,startDate: collection.date)
            }
            return cell
        }else{
            return  CollectionCell()
        }
    }
    func openProfile(collection:FollowingResponseRecords) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        profile.getFName = collection.fName
        profile.getLName = collection.lName
        
        profile.getCity = collection.education
        profile.getRole = collection.education
        profile.getImage = collection.ownerPic
        profile.followedByMe = 1
        profile.profileId = collection.owner_id
        profile.getOwner = owner
        profile.bio = ""
        self.present(profile, animated: true, completion: nil)
        
    }
    @IBOutlet weak var collectionTV :UITableView!
    

}
 
