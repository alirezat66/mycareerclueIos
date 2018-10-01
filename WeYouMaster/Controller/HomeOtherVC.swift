//
//  HomeOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip

class HomeOtherVC: UIViewController,UITableViewDelegate,UITableViewDataSource , IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "تایم لاین")
    }
    
    var myContent : [OtherContent] = []
    var isOpenMenu = false
    
    var refreshControll : UIRefreshControl?

    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        homeTable.addSubview(refreshControll!)
    }
    @objc func refreshList(){
        myContent = []
        getFeeds()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
        let content = myContent[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeOtherCell {
            cell.updateView(content: content)
            
           
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
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
      /*  profile.getName = content.fName! + content.lName!
        profile.getCity = content.location!
        profile.getRole = content.education!
        profile.getImage = content.ownerPic!
        profile.followedByMe = content.followByMe!*/
        self.present(profile, animated: true, completion: nil)
    }
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var homeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        
        
        addRefreshControl()
        getFeeds()
    }
    override func viewDidAppear(_ animated: Bool) {
        
     
        homeTable.dataSource = self
        homeTable.delegate = self
      
        
        
        
        
       
        // Do any additional setup after loading the view.
        
        
    }
    func getFeeds(){
        let userDefaults = UserDefaults.standard
        
        let owner = userDefaults.value(forKey: "otherUser") as! String
        WebCaller.getUserFeed(50, 1,owner
        ) { (contents, error) in
            if let error = error{
                self.updateError()
                print(error)
                return
            }
            guard let contentList = contents else{
                self.updateError()
                print("error getting collections")
                return
            }
            for content in (contentList.records) {
                self.myContent.append(content)
            }
            self.updateUI()
        }
    }
    
    func updateUI(){
        DispatchQueue.main.async{
            self.homeTable.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()

            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            self.homeTable.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
}
