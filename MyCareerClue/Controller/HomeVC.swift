//
//  HomeVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import MDHTMLLabel
import AVKit
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource , MDHTMLLabelDelegate {
    var firstTime = true
    var states : Array<Bool>!
   
   
    var tipId : String!
    var tipLink : String!
    @IBOutlet weak var uiShowLabel : UILabel!
    @IBAction func btnShowTips(_ sender: Any) {
        acceptTip()
    }
    @IBAction func btnCancelTips(_ sender: Any) {
        cancelTip()
    }
    @IBOutlet weak var viewNewUse: UIView!
    
    
    
   
   
    

    
    
    var myContent : [Content] = []
    var isOpenMenu = false
    
    @IBAction func btnSearch(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let search = storyBoard.instantiateViewController(withIdentifier: "searchVC") as! SearchVC
        
        self.present(search,animated: true,completion: nil)
    }
    let cellSpacingHeight: CGFloat = 10

  
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
        if(myContent.count == 0 ){
            if(!firstTime){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Reported clues will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myContent.count
    }
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
    @IBAction func btnGoToDashbord(_ sender: Any) {
        openMyProfile()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
        let content = myContent[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
            cell.updateView(content: myContent[indexPath.row])
            
          
            cell.onCollectionTap = {
                self.collectionTaped(content : content)
            }
            cell.onReportTapped = {
                self.report(content:content);
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
                // agar zade bood ke kolesho bebine
                if(content.contentText!.count > 200)
                {
                    // agar kolesh bozorgtar az 200 charecter bood
                     cell.lblText.htmlText = content.contentText
                    cell.btnShowLink.setTitle("Less", for: .normal)
                    cell.btnShowLink.isHidden = false

                    
                }else{
                    // agar kolesh bozorgtar az 200 charecter nabood
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
                            
                            if(mstr.count > endIndex /*+ 50*/){
                                let hasan = mstr.prefix(endIndex + 3 /*+ 50*/);
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
   
    @IBOutlet weak var brnShow: UIButton!
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
       
        let imgView = tapGestureRecognizer.view as! UIImageView
        if(myContent[imgView.tag].contentType == 2){
            print("your taped image view tag is : \(imgView.tag)")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let fullscreen = storyBoard.instantiateViewController(withIdentifier: "fullscreen") as! fullScreenImageVC
            print(myContent.count)
            fullscreen.imgAddress = myContent[imgView.tag].imgSource!
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
  
    func openMyProfile()  {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        let name = userDefaults.value(forKey: "fName") as! String
        let lName = userDefaults.value(forKey: "lName") as! String
        profile.getFName = name
        profile.getLName = lName
        profile.getCity = userDefaults.value(forKey: "City") as! String
        profile.getRole = userDefaults.value(forKey: "job")as! String

        profile.getImage = userDefaults.value(forKey: "profilePhoto")as! String
        profile.followedByMe = 1
        profile.profileId = owner
        profile.getOwner = owner
        profile.bio = userDefaults.value(forKey: "bio")as! String
        self.present(profile, animated: true, completion: nil)

    }
    @objc func notifTap() {
        // present modally
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "likeOthers") as! CommentLikeOtherVC
        self.present(detail, animated: true, completion: nil)
    }
    
    @IBOutlet weak var stackNotif: UIStackView!
     func report(content:Content) {
        
        
        
        
        let refreshAlert = UIAlertController(title: "Report Clue", message: "Are you sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            SVProgressHUD.show(withStatus: "Please Wait... \n\n")
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            WebCaller.report(content.postId!,owner
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
                
                if(contentList.error==0){
                    self.deleteItem(content: content)
                }else{
                    DispatchQueue.main.async{
                        SVProgressHUD.dismiss()
                    }
                }
                
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
        
        
        
        
       
    }
    
    func deleteItem(content : Content)  {
        DispatchQueue.main.async{
            let index =  self.myContent.firstIndex(of: content)
            if(index != nil){
                self.homeTable.beginUpdates()
                self.homeTable.deleteRows(at: [ IndexPath(row: index!, section: 0) ], with: .fade)
                self.myContent.remove(at: index!)
                self.homeTable.endUpdates()
            }
            self.refreshControll?.endRefreshing()
            SVProgressHUD.dismiss()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
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
    func namesaverTap(content:Content) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let saverList = storyBoard.instantiateViewController(withIdentifier: "saverOfContList") as! SaverOfContributeVC
        saverList.getOwner =  content.owner_id ?? ""
        saverList.getContributionId = content.postId ?? ""
        self.present(saverList, animated: true, completion: nil)
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
    @IBOutlet weak var homeTable: UITableView!
    override func viewDidLoad() {
        myContent = []
        stackNotif.isUserInteractionEnabled = true
        stackNotif.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.notifTap)))
        imgNot5.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.notifTap)))
       
        homeTable.dataSource = self
        homeTable.delegate = self
        homeTable.rowHeight = UITableViewAutomaticDimension
    //    homeTable.tableFooterView = UIView.init(frame : .zero)
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        let userDefaults = UserDefaults.standard
        
        
        
        
        
        
        let Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        if(Profile_photo_link != ""){
            
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
        }else{
            DispatchQueue.main.async {
                self.imgProfile.setImage(UIImage(named: "avatar_icon.png"), for: UIControlState.normal)
            }
        }
        // Do any additional setup after loading the view.
        SVProgressHUD.show(withStatus: "Please Wait... \n\n")
        getFeeds()
        
        showTip()
        super.viewDidLoad()
        
        
        
        
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
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
        self.firstTime = true
        getNotifs()
        
        let userDefaults = UserDefaults.standard
        if(UserDefaults.standard.object(forKey: "deletedId") != nil){
        let deletedId = userDefaults.value(forKey: "deletedId") as! String
            
            userDefaults.removeObject(forKey: "deleteId")
            for content in myContent {
                if(content.owner_id == deletedId){
                    deleteItem(content: content)
                    break
                }
                
            }
            
        }
        addRefreshControl()
        if(UserDefaults.standard.object(forKey: "isBlock") != nil){
            myContent = []
            homeTable.reloadData()
            SVProgressHUD.show(withStatus: "Please Wait... \n\n")
            userDefaults.removeObject(forKey: "isBlock")
            getFeeds()
            
        }
        if(UserDefaults.standard.object(forKey: "imageUpdated") != nil){
            let profileImage = userDefaults.value(forKey: "profilePhoto") as! String
            let Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
            if(Profile_photo_link != ""){
                
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
            userDefaults.removeObject(forKey: "imageUpdated")
            }
        }
            
        
    }
    func getNotifs() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getNotif(owner
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
           
            self.updateNotif(notif: contentList)
        }
    }
    func updateNotif(notif : NotifResponse)  {
         DispatchQueue.main.async{
            if(notif.c1_1==1){
                self.imgNot1.backgroundColor = UIColor.red
            }
            if(notif.c1_2==1){
                self.imgNot4.backgroundColor =  UIColor(red:99/256, green:213/256, blue:223/256, alpha:1.0)
            }
            if(notif.c1_3==1){
                self.imgNot7.backgroundColor = UIColor(red:239/256, green:66/256, blue:69/256, alpha:1.0)
            }
            
        }
    }
    func showTip(){
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getTips(owner
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
            if(contentList.records.count > 0 ){
                  DispatchQueue.main.async{
                self.viewNewUse.isHidden = false
                self.uiShowLabel.text = contents?.records[0].tip_title
            self.brnShow.setTitle(contents?.records[0].tip_subtitle, for: .normal)
                }
                self.tipId = contents?.records[0].tip_id
                
                self.tipLink = contents?.records[0].tip_link
            }else {
                  DispatchQueue.main.async{
                self.viewNewUse.isHidden = true
                }
            }
           
          
        }
    
    }
    func cancelTip(){
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.cancelTips(owner,tipId
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
            print(contentList)
            DispatchQueue.main.async{
                self.viewNewUse.isHidden = true
            }
            
            
        }
    }
    func acceptTip() {
        
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.acceptTips(owner,tipId
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
            print(contentList)
            DispatchQueue.main.async{
                self.viewNewUse.isHidden = true
            }
            
            
        }
        let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
        
        let qaPage = StoryBoard.instantiateViewController(withIdentifier: "QA" ) as? QAVC
        self.present(qaPage!, animated: true, completion: nil)
    }
    func getFeeds(){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getFeeds(20, 1,owner
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
                var a = content
                a.contentText = content.contentText?.replacingOccurrences(of: "&nbsp;", with: "")
                self.myContent.append(a)
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
            self.firstTime = false
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
