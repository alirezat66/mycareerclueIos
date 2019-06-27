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
            
          /*  cell.lblText.delegate = self
            cell.lblText.attributedText = content.contentText?.htmlToAttributedString
            cell.lblText.collapsedAttributedLink = NSAttributedString(string: "بیشتر")
            cell.lblText.setLessLinkWith(lessLink: "کمتر", attributes: [.foregroundColor:UIColor.red], position: NSTextAlignment.left)
             cell.layoutIfNeeded()
            cell.lblText.shouldCollapse = true
            cell.lblText.textReplacementType = .word
            cell.lblText.numberOfLines =  4
            cell.lblText.collapsed = true*/
           
           

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
                    cell.btnShowLink.setTitle("کمتر", for: .normal)
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
                                
                                cell.btnShowLink.setTitle("بیشتر", for: .normal)
                                cell.btnShowLink.isHidden = false
                                
                            }else{
                                
                                // inja kole matno namayesh dadim
                                let hasan = mstr
                                let ali = String(hasan)
                                cell.lblText.htmlText = ali;
                                
                                cell.btnShowLink.setTitle("بیشتر", for: .normal)
                                cell.btnShowLink.isHidden = true
                            }
                            
                            
                            
                            
                        }
                    }
                    else{
                        // tage a nadarim
                        
                        let hasan = mystr.prefix(200);
                        // bad az tage a bish az 50 char darim dar natije dokme more mikhaym
                        let ali = String(hasan)
                        cell.lblText.htmlText = ali;
                        
                        cell.btnShowLink.setTitle("بیشتر", for: .normal)
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
        if(myContent[imgView.tag].contentType == 2){
            print("your taped image view tag is : \(imgView.tag)")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let fullscreen = storyBoard.instantiateViewController(withIdentifier: "fullscreen") as! fullScreenImageVC
            print(myContent.count)
            fullscreen.imgAddress = myContent[imgView.tag].imgSource!
            self.present(fullscreen,animated: true,completion: nil)
        }else {
            let s =  "https://weyoumaster.com/" + myContent[imgView.tag].videoSource!
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
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        
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
        getNotifs()
        addRefreshControl()
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
