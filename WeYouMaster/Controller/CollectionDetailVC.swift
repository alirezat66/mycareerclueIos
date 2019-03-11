//
//  CollectionDetailVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/21/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip

class CollectionDetailVC:
    
UIViewController,UITableViewDelegate,UITableViewDataSource , IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "مشارکت ها")
    }
    
    var refreshControll : UIRefreshControl?
    
    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        contentTable.addSubview(refreshControll!)
    }
    var myContent : [Content] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myContent.count //DataService.instance.getContent().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
            if(myContent.count >= indexPath.row){
                let content = myContent[indexPath.row]
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
                    cell.updateView(content: myContent[indexPath.row])
                    
                    cell.onButtonTapped = {
                        self.openProfile(content : content)
                    }
                    return cell
                }else{
                    return HomeCell()
                }
            }else{
                return HomeCell()
            }
       
    }
    func openProfile(content:Content) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        profile.getFName = content.fName!
        profile.getLName = content.lName!
        profile.getCity = content.location!
        profile.getRole = content.education!
        profile.getImage = content.ownerPic!
        profile.followedByMe = content.followByMe!
        profile.profileId = content.owner_id!
        profile.getOwner = owner
        profile.bio = ""
        self.present(profile, animated: true, completion: nil)
    }
    @objc func refreshList(){
        myContent = []
        getFeeds()
    }
    

    
   
    var collectionId = String()
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
    }
    @IBOutlet weak var contentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        
      
        contentTable.dataSource = self
        contentTable.delegate = self
        contentTable.tableFooterView = UIView.init(frame : .zero)

        
        
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getFeeds()
        // Do any additional setup after loading the view.
    }

    func getFeeds(){
       
       
     /*   WebCaller.getFeedsOfCollection(collectionId
        ) { (contents, error) in
            if let error = error{
                print(error)
                return
            }
            guard let contentList = contents else{
                print("error getting collections")
                return
            }
            for content in (contentList.records.posts) {
                self.myContent.append(content)
            }
            self.updateUI()
        
        }*/
    }
    
    func updateUI(){
        DispatchQueue.main.async{
            self.contentTable.reloadData()
                SVProgressHUD.dismiss()
            
            
        }
    }
    
}
