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
    var firstTime  = true
    @IBOutlet weak var homeTable: UITableView!
    var refreshControll : UIRefreshControl?

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(myContent.count == 0){
            if(!firstTime){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Liked Clues will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myContent.count
    }
    override func viewDidLoad() {
        
        myContent = []
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
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
    func namesaverTap(content:Content) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let saverList = storyBoard.instantiateViewController(withIdentifier: "saverOfContList") as! SaverOfContributeVC
        saverList.getOwner =  content.owner_id ?? ""
        saverList.getContributionId = content.postId ?? ""
        self.present(saverList, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
            let content = myContent[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
                cell.updateView(content: myContent[indexPath.row])
                cell.onCollectionTap = {
                    self.collectionTaped(content : content)
                }
                cell.onBtnShowMeTap = {
                    self.namesaverTap(content: content)
                }
                cell.onButtonTapped = {
                    self.openProfile(content : content)
                }
                cell.onTextTap = {
                    if(self.states[indexPath.row] == true){
                        self.states[indexPath.row] = false
                        
                        self.homeTable.reloadRows(at: [indexPath], with: .automatic)
                        
                    }else {
                        self.states[indexPath.row] = true
                        self.homeTable.reloadRows(at: [indexPath], with: .automatic)
                        
                    }
                }
                
                if(self.states[indexPath.row] == false){
                    if(content.contentText!.count > 200)
                    {
                        cell.lblText.htmlText = content.contentText
                        cell.btnShowLink.setTitle("Less", for: .normal)
                        cell.btnShowLink.isHidden = false
                        
                        
                    }else{
                        cell.lblText.htmlText = content.contentText
                        cell.btnShowLink.isHidden = true
                    }
                    
                }else {
                    if(content.contentText!.count > 200)
                    {
                        // by defualt bayad beshinim
                        // va more bezarim
                        let mystr =  content.contentText ?? "" ;
                        let mstr = String(mystr)
                        // ama momkene tage <a dashte bashim
                        if(mstr.contains("<a")){
                            
                            // yani tag a darim
                            let range = mstr.range(of: "<a")
                            
                            let aIndex : Int = mstr.distance(from: mystr.startIndex, to: range!.lowerBound)
                            if(aIndex < 200){
                                let rangeEnd = mstr.range(of: "/a>")
                                let endIndex : Int = mstr.distance(from: mystr.startIndex, to: rangeEnd!.lowerBound)
                                // ghabl az 200 char yedoone link darim
                                
                                if(mstr.count > endIndex + 50){
                                    let hasan = mstr.prefix(endIndex + 50);
                                    // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                                    let ali = String(hasan)
                                    cell.lblText.htmlText = ali;
                                    
                                    cell.btnShowLink.setTitle("More", for: .normal)
                                    cell.btnShowLink.isHidden = false
                                    
                                }else{
                                    
                                    // inja kole matno namayesh dadim
                                    let hasan = mstr
                                    let ali = String(hasan)
                                    cell.lblText.htmlText = ali;
                                    
                                    cell.btnShowLink.setTitle("More", for: .normal)
                                    cell.btnShowLink.isHidden = true
                                }
                                
                                
                                
                                
                            }else{
                                let hasan = mystr.prefix(200);
                                // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                                let ali = String(hasan)
                                cell.lblText.htmlText = ali;
                                
                                cell.btnShowLink.setTitle("More", for: .normal)
                                cell.btnShowLink.isHidden = false
                            }
                        }
                        else{
                            // tage a nadarim
                            
                            let hasan = mystr.prefix(200);
                            // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                            let ali = String(hasan)
                            cell.lblText.htmlText = ali;
                            
                            cell.btnShowLink.setTitle("More", for: .normal)
                            cell.btnShowLink.isHidden = false
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }else{
                        cell.lblText.htmlText = content.contentText
                        cell.btnShowLink.isHidden = true
                        
                    }
                    
                }
                cell.lblText.delegate = self
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
            self.firstTime = false
            self.homeTable.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.firstTime  = false
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
