//
//  HomeVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import ExpandableLabel
class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource, ExpandableLabelDelegate {
    var states : Array<Bool>!
    func willExpandLabel(_ label: ExpandableLabel) {
        label.textAlignment = NSTextAlignment.right
        homeTable.beginUpdates()
        label.textAlignment = NSTextAlignment.right

    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: homeTable)
        if let indexPath = homeTable.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            
            DispatchQueue.main.async { [weak self] in
                self?.homeTable.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        label.textAlignment = NSTextAlignment.right
        homeTable.endUpdates()
        label.textAlignment = NSTextAlignment.right

    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        label.textAlignment = NSTextAlignment.right

        homeTable.beginUpdates()
        label.textAlignment = NSTextAlignment.right

    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        
        let point = label.convert(CGPoint.zero, to: homeTable)
        if let indexPath = homeTable.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.homeTable.scrollToRow(at: indexPath, at: .top, animated: true)

            }
        }
        label.textAlignment = NSTextAlignment.right
        homeTable.endUpdates()
        label.textAlignment = NSTextAlignment.right

    }
    

    
    
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
            cell.lblText.delegate = self
            
            cell.lblText.collapsedAttributedLink = NSAttributedString(string: "بیشتر")
            cell.lblText.setLessLinkWith(lessLink: "کمتر", attributes: [.foregroundColor:UIColor.red], position: NSTextAlignment.left)
             cell.layoutIfNeeded()
            cell.lblText.shouldCollapse = true
            cell.lblText.textReplacementType = .word
            cell.lblText.numberOfLines =  4
            cell.lblText.collapsed = true
            cell.lblText.text = content.contentText
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
    
    
   
}
