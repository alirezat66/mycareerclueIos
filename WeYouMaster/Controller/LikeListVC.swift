//
//  LikeList.swift
//  WeYouMaster
//
//  Created by alireza on 6/6/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import MDHTMLLabel
class LikeListVC: UIViewController,UITableViewDelegate,UITableViewDataSource,MDHTMLLabelDelegate {
    var states : Array<Bool>!
     var myContent : [Content] = []
    @IBOutlet weak var homeTable: UITableView!
    var refreshControll : UIRefreshControl?

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContent.count
    }
    override func viewDidLoad() {
        
        myContent = []
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        homeTable.dataSource = self
        homeTable.delegate = self
        homeTable.rowHeight = UITableViewAutomaticDimension
        getFeeds();
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @objc func refreshList(){
        myContent = []
        getFeeds()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
            let content = myContent[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
                cell.updateView(content: myContent[indexPath.row])
                
                /*  cell.lblText.delegate = self
                 cell.lblText.attributedText = content.contentText?.htmlToAttributedString
                 cell.lblText.collapsedAttributedLink = NSAttributedString(string: "بیشتر")
                 cell.lblText.setLessLinkWith(lessLink: "کمتر", attributes: [.foregroundColor:UIColor.red], position: NSTextAlignment.left)
                 cell.layoutIfNeeded()
                 cell.lblText.shouldCollapse = true
                 cell.lblText.textReplacementType = .word
                 cell.lblText.numberOfLines =  4
                 cell.lblText.collapsed = true*/
                
                cell.lblText.htmlText = content.contentText
                cell.lblText.delegate = self
                // cell.lblText.text = content.contentText
                
                //cell.lblText.text =  content.contentText.
                cell.lblText.textAlignment = NSTextAlignment.right
                
                /*   lblText.numberOfLines = 6
                 lblText.collapsed = true
                 lblText.collapsedAttributedLink = NSAttributedString(string: "بیشتر")
                 
                 lblText.expandedAttributedLink = NSAttributedString(string: "کمتر")
                 lblText.ellipsis = NSAttributedString(string: "...")
                 
                 //  contentText = content.contentText!
                 
                 if(content.allignment != "rtl"){
                 lblTitle.textAlignment = .left
                 lblText.textAlignment = .left
                 }else {
                 lblTitle.textAlignment = .right
                 lblText.textAlignment = .right
                 }
                 lblText.text = content.contentText*/
                cell.onCollectionTap = {
                    self.collectionTaped(content : content)
                }
                cell.onButtonTapped = {
                    self.openProfile(content : content)
                }
                cell.imgContent?.tag = indexPath.row
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                tapGestureRecognizer.numberOfTapsRequired = 1
                cell.imgContent?.isUserInteractionEnabled = true
                cell.imgContent?.addGestureRecognizer(tapGestureRecognizer)
                return cell
            }else{
                return HomeCell()
            }
        }else{
            return HomeCell()
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imgView = tapGestureRecognizer.view as! UIImageView
        print("your taped image view tag is : \(imgView.tag)")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let fullscreen = storyBoard.instantiateViewController(withIdentifier: "fullscreen") as! fullScreenImageVC
        print(myContent.count)
        fullscreen.imgAddress = myContent[imgView.tag].imgSource!
        self.present(fullscreen,animated: true,completion: nil)
    }
    func collectionTaped(content:Content) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "collectionDetail") as! CollectionDetailTwoVC
        let userDefaults = UserDefaults.standard
        userDefaults.set(content.owner_id, forKey: "otherUser")
        detail.getDegree = content.education!
        detail.getName = content.fName! + " " + content.lName!
        detail.getTitle = content.collectionName ?? ""
        detail.getImage = content.ownerPic ?? ""
        detail.collectionId = content.collectionId ?? ""
        detail.numberOdPost = 1
        detail.getStartDate = content.date ?? ""
        self.present(detail, animated: true, completion: nil)
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
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }

    func getFeeds(){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getLikeList(viewer_id: owner
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
            self.states = [Bool](repeating: true, count: contentList.records.count)
            
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
    func htmlLabel(_ label: MDHTMLLabel!, didSelectLinkWith URL: URL!) {
        guard let url = URL else { return }
        UIApplication.shared.open(url)
        print(URL.absoluteURL)
    }
    
}
