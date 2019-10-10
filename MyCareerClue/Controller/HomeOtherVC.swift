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
import MDHTMLLabel
import AVKit
class HomeOtherVC: UIViewController,UITableViewDelegate,UITableViewDataSource , IndicatorInfoProvider , MDHTMLLabelDelegate{
    var collectionId = String()
    var firstTime = true
    var states : Array<Bool>!
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "CLUES")
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
        if(myContent.count == 0 ){
            if(!firstTime){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Clues will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
        let content = myContent[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeOtherCell {
            cell.updateView(content: content)
            
            cell.onTextTap = {
                if(self.states[indexPath.row] == true){
                    self.states[indexPath.row] = false
                    self.homeTable.reloadRows(at: [indexPath], with: .none)
                    
                }else {
                    self.states[indexPath.row] = true
                    self.homeTable.reloadRows(at: [indexPath], with: .none)
                    
                }
            }
            if(self.states[indexPath.row] == false){
                if(content.contentText.count > 200)
                {
                    cell.lblContent.htmlText = content.contentText
                    cell.btnShowLink.setTitle("less", for: .normal)
                    cell.btnShowLink.isHidden = false
                    
                    
                }else{
                    cell.lblContent.htmlText = content.contentText
                    cell.btnShowLink.isHidden = true
                }
                
            }else {
                if(content.contentText.count > 200)
                {
                    // by defualt bayad beshinim
                    // va more bezarim
                    let mystr =  content.contentText ;
                    let mstr = String(mystr)
                    // ama momkene tage <a dashte bashim
                   if(mstr.contains("<a") || mstr.contains("<b>") || mstr.contains("<i>")){
                        
                        // yani tag a darim
                    let range  = mstr.range(of: "<a")
                    let rangeEnd  = mstr.range(of: "/a>")
                    let range2 = mstr.range(of: "<b>")
                    let range2End = mstr.range(of: "</b>")
                    let range3 = mstr.range(of: "<i>")
                    let range3End = mstr.range(of: "</i>")
                    var aIndex = 0;
                    var aIndexEnd = 0
                    var bIndex = 0;
                    var bIndexEnd = 0
                    var cIndex = 0
                    var cIndexEnd = 0
                    if(range != nil && rangeEnd != nil){
                        aIndex  = mstr.distance(from: mystr.startIndex, to: range!.lowerBound)
                        aIndexEnd = mstr.distance(from: mystr.startIndex, to: rangeEnd!.lowerBound)
                    }
                    if(range2 != nil && range2 != nil){
                        bIndex = mstr.distance(from: mystr.startIndex, to: range2!.lowerBound)
                        bIndexEnd = mstr.distance(from: mystr.startIndex, to: range2End!.lowerBound)
                    }
                    if(range3 != nil && range3End != nil){
                        cIndex = mstr.distance(from: mystr.startIndex, to: range3!.lowerBound)
                        cIndexEnd = mstr.distance(from: mystr.startIndex, to: range3End!.lowerBound)
                    }

                        if((aIndex < 200 && aIndexEnd>200) || (bIndex < 200 && bIndexEnd>200) || (cIndex < 200 && cIndexEnd>200)){
                            if(aIndex > 200){
                                aIndexEnd = 0
                            }
                            if(bIndex > 200){
                                bIndexEnd = 0
                            }
                            if(cIndex > 200) {
                                cIndexEnd = 0
                            }
                            let largest = max(max(aIndexEnd, bIndexEnd), cIndexEnd)
                            var rangeEnd = mstr.range(of: "/a>")
                            if (largest == bIndexEnd){
                                rangeEnd = mstr.range(of: "/b>")
                            }else if (largest == cIndexEnd) {
                                rangeEnd = mstr.range(of: "/i>")
                            }
                            let endIndex : Int = mstr.distance(from: mystr.startIndex, to: rangeEnd!.lowerBound)
                            // ghabl az 200 char yedoone link darim
                            
                            if(mstr.count > endIndex){
                                let hasan = mstr.prefix(endIndex + 3);
                                // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                                let ali = String(hasan)
                                cell.lblContent.htmlText = ali;
                                
                                cell.btnShowLink.setTitle("More", for: .normal)
                                cell.btnShowLink.isHidden = false
                                
                            }else{
                                
                                // inja kole matno namayesh dadim
                                let hasan = mstr
                                let ali = String(hasan)
                                cell.lblContent.htmlText = ali;
                                
                                cell.btnShowLink.setTitle("More", for: .normal)
                                cell.btnShowLink.isHidden = true
                            }
                            
                            
                            
                            
                        }else{
                            let hasan = mystr.prefix(200);
                            // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                            let ali = String(hasan)
                            cell.lblContent.htmlText = ali;
                            
                            cell.btnShowLink.setTitle("More", for: .normal)
                            cell.btnShowLink.isHidden = false
                        }
                    }
                    else{
                        // tage a nadarim
                        
                        let hasan = mystr.prefix(200);
                        // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                        let ali = String(hasan)
                        cell.lblContent.htmlText = ali;
                        
                        cell.btnShowLink.setTitle("More", for: .normal)
                        cell.btnShowLink.isHidden = false
                    }
                    
                    
                    
                    
                    
                    
                    
                    
                }else{
                    cell.lblContent.htmlText = content.contentText
                    cell.btnShowLink.isHidden = true
                    
                }
                
            }
            cell.lblContent.delegate = self
            // cell.lblText.text = content.contentText
            
            //cell.lblText.text =  content.contentText.
      //      cell.lblContent.text = content.contentText
        //    cell.lblContent.textAlignment = NSTextAlignment.right
            cell.onButtonDeleteTapped = {
                 self.deleteItem(contentId: content.postId,index: indexPath.row)
            }
            cell.onBtnShowMeTap = {
                self.namesaverTap(content: content)
            }
            cell.onButtonEditTapped = {
                self.editItem(content: content,contentId : content.postId,index : indexPath.row)

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
    func namesaverTap(content:OtherContent) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let saverList = storyBoard.instantiateViewController(withIdentifier: "saverOfContList") as! SaverOfContributeVC
        saverList.getOwner =  content.owner_id
        saverList.getContributionId = content.postId
        self.present(saverList, animated: true, completion: nil)
    }
    func editItem(content : OtherContent ,contentId : String , index : Int){
        
        let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
        let add = stroyBoard.instantiateViewController(withIdentifier: "addcontribution" ) as? AddContribution
        
        add?.isEdit = true
        add?.editContentId = contentId
        add?.editTitle = content.title
        add?.editCollection = content.collectionId
        add?.editCollectionTitle = content.collectionName
        add?.editDescription = content.contentText
        add?.editRtl = content.allignment
        add?.editLocation = content.location
        self.present(add!, animated: true, completion: nil)
        
        
        
    }
    func deleteItem(contentId : String , index : Int){
        
        let refreshAlert = UIAlertController(title: "delete", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            SVProgressHUD.show(withStatus: " Please Wait  ... \n\n")
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            
            WebCaller.deleteContent(owner,contentId) { (errorMessage , error) in
                if let error = error{
                    self.updateError()
                    print(error)
                    return
                }
                guard let errorMessage = errorMessage else{
                    self.updateError()
                    print("error getting collections")
                    return
                }
                
                
                if(errorMessage.error==0){
                    self.myContent.remove(at: index)
                    self.updateUI()
                }
                
                
                
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
    }
    func openProfile(content:Content) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
        profile.getFName = content.fName!
        profile.getLName = content.lName!
      /*  profile.getName = content.fName! + content.lName!
        profile.getCity = content.location!
        profile.getRole = content.education!
        profile.getImage = content.ownerPic!
        profile.followedByMe = content.followByMe!*/
        self.present(profile, animated: true, completion: nil)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
         let imgView = tapGestureRecognizer.view as! UIImageView
        if(myContent[imgView.tag].contentType == 2){
        let imgView = tapGestureRecognizer.view as! UIImageView
        print("your taped image view tag is : \(imgView.tag)")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let fullscreen = storyBoard.instantiateViewController(withIdentifier: "fullscreen") as! fullScreenImageVC
        print(myContent.count)
        fullscreen.imgAddress = myContent[imgView.tag].imgSource
        self.present(fullscreen,animated: true,completion: nil)
        }else {
            let s =  "https://mycareerclue.com/" + myContent[imgView.tag].videoSource!
            let mUrl = URL(string:  s)
            let player = AVPlayer(url: mUrl! )
            let vc = AVPlayerViewController()
            vc.player = player
            
            present(vc, animated: true) {
                vc.player?.play()
            }
        }
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
        homeTable.rowHeight = UITableViewAutomaticDimension
        SVProgressHUD.show(withStatus: "Please Wait   ... \n\n")
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
        
        let userId = userDefaults.value(forKey: "otherUser") as! String
        let owner = userDefaults.value(forKey: "owner") as! String
        
        
        if(collectionId == ""){
        WebCaller.getUserFeed(50, 1,userId,owner
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
            for content in (contentList.contributions) {
                var a = content
                 a.contentText = content.contentText.replacingOccurrences(of: "&nbsp;", with: "")
                self.myContent.append(content)
            }
             self.states = [Bool](repeating: true, count: contentList.contributions.count)
            self.updateUI()
        }
        }else{
            firstTime  = false
            WebCaller.getFeedsOfCollectionThree(collectionId
            ) { (contents, error) in
                if let error = error{
                    print(error)
                    return
                }
                guard let contentList = contents else{
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
    func htmlLabel(_ label: MDHTMLLabel!, didSelectLinkWith URL: URL!) {
        guard let url = URL else { return }
        UIApplication.shared.open(url)
        print(URL.absoluteURL)
    }
}
