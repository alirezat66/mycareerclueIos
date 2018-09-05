//
//  HomeVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    
    var myContent : [Content] = []
    var isOpenMenu = false
    
    
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

    var refreshControll : UIRefreshControl?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContent.count
    }
    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        homeTable.addSubview(refreshControll!)
    }
    @objc func refreshList(){
        getFeeds()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    func openProfile(content:Content) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
        profile.getName = content.fName! + content.lName!
        profile.getCity = content.location!
        profile.getRole = content.education!
        profile.getImage = content.ownerPic!
        profile.followedByMe = content.followByMe!
        profile.profileId = content.owner_id!
        self.present(profile, animated: true, completion: nil)
    }
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }
    @IBOutlet weak var homeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        makeButtonCirc(obj: imgNot1)
        makeButtonCirc(obj: imgNot2)
        makeButtonCirc(obj: imgNot3)
        makeButtonCirc(obj: imgNot4)
        makeButtonCirc(obj: imgNot5)
        makeButtonCirc(obj: imgNot6)
        makeButtonCirc(obj: imgNot7)
        makeButtonCirc(obj: imgNot8)
        makeButtonCirc(obj: imgNot9)
        myContent = []
        updateUI()
        imgNot1.backgroundColor = UIColor.red
        imgNot3.backgroundColor = UIColor.blue
        homeTable.dataSource = self
        homeTable.delegate = self
        homeTable.tableFooterView = UIView.init(frame : .zero)
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        
        
        
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
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
        // Do any additional setup after loading the view.
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        
        getFeeds()
        addRefreshControl()
    }
    func getFeeds(){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getFeeds(50, 1,owner
        ) {
            
            (contents, error) in
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
    
    func updateError(){
         DispatchQueue.main.async{
        SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.homeTable.reloadData()
            self.refreshControll?.endRefreshing()
            SVProgressHUD.dismiss()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    
    
    
}
