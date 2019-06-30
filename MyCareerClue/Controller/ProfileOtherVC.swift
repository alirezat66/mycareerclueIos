//
//  ProfileOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class ProfileOtherVC: UIViewController , IndicatorInfoProvider{

    
    
    @IBOutlet weak var allview: UIScrollView!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    
    @IBOutlet weak var lblSaves: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblBuys: UILabel!
    @IBOutlet weak var activitiesView: UIView!
    @IBOutlet weak var btnSetting : UIButton!

     @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var btnFirst : UIButton!
    @IBOutlet weak var btnSecond : UIButton!
    
    
    @IBOutlet weak var likeView: UIView!
    
    @IBOutlet weak var followersView: UIView!
    
    @objc func checkAction(_ sender:UITapGestureRecognizer){
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let likeListPage = storyBoard.instantiateViewController(withIdentifier: "likeList") as! LikeListVC
        
        self.present(likeListPage, animated: true, completion: nil)
    }
    @objc func followingAction(_ sender:UITapGestureRecognizer){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let folllowingListPage = storyBoard.instantiateViewController(withIdentifier: "followingList") as! FollowingCollectionVC
        
        self.present(folllowingListPage, animated: true, completion: nil)
    }
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        if(!isOwner){
            let userDefaults = UserDefaults.standard
            userDefaults.set(getFName  + " " + getLName, forKey: "lastname")
            userDefaults.set(getOwner, forKey: "lastId")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let sendPm = storyBoard.instantiateViewController(withIdentifier: "sendPm") as! SendPmVC
            
            self.present(sendPm, animated: true, completion: nil)
            
        }else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detail = storyBoard.instantiateViewController(withIdentifier: "addCollection") as! AddCollectionVC
            
            self.present(detail, animated: true, completion: nil)
        }
    }
    
    var getFName = String()
    var getLName = String()
    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var followedByMe = Int()
    var getOwner = String()
    var bio = String()
    var isOwner : Bool!
    
    @IBAction func btnProfileEdit(_ sender: Any) {
        if(isOwner){
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let profEdit = storyBoard.instantiateViewController(withIdentifier: "profilePage") as! ProfileVC
            profEdit.bio = bio
            profEdit.getImage = getImage
            profEdit.getCity = getCity
            profEdit.getRole = getRole
            profEdit.getOwner = getOwner
            profEdit.getName = getFName
            profEdit.getLName = getLName
         
            self.present(profEdit,animated: true,completion: nil)
        }
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)?)
    {
        super.dismiss(animated: flag, completion:completion)
        reload()
        
        // Your custom code here...
    }
    func reload() {
        let userDefaults = UserDefaults.standard
        let name = userDefaults.value(forKey: "fName") as! String
        let lName = userDefaults.value(forKey: "lName") as! String
        let city = userDefaults.value(forKey: "City") as! String
        let job = userDefaults.value(forKey: "job") as! String
        let bio = userDefaults.value(forKey: "bio") as! String
        
        lblBio.text = bio
        lblrole.text = job
        lblName.text = name + " " + lName
        lblPlace.text = city

    }
    @IBAction func btnLikeOrNew(_ sender: Any) {
        if(getOwner==profileId){
            // is new post
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let add = storyBoard.instantiateViewController(withIdentifier: "selectContributeType") as! SelectContriButeType
            let userDefaults = UserDefaults.standard
            userDefaults.set("0", forKey: "selectedCollection")
            self.present(add, animated: true, completion: nil)
        }else{
            allview.isHidden = true
            SVProgressHUD.show(withStatus: "Please Wait ... \n\n")

            if(followedByMe==1){
                callDisLike(follow: 1)
            }else{
                callDisLike(follow: 0)
            }
        }
    }
    
    func callDisLike(follow : Int) {

        
        WebCaller.followDisFollow(follow, getOwner,profileId) { (state, error) in
            if let error = error{
                print(error)
                return
            }
            guard let state = state else{
                print("error getting collections")
                return
            }
            if(state == 1 ){
                print("like done")
                if(follow == 1){
                    self.followedByMe = 0
                    DispatchQueue.main.async{
                        SVProgressHUD.dismiss()

                    self.btnSecond.setTitle("Follow", for: .normal)
                    }
                }else{
                    DispatchQueue.main.async{
                        SVProgressHUD.dismiss()

                        self.followedByMe = 1
                    self.btnSecond.setTitle("Following", for: .normal)
                    }
                }
            }
        }
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title : "PROFILE")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.checkAction))
        let gesture2 = UITapGestureRecognizer(target: self, action:  #selector(self.followingAction))
        
        
        self.likeView.addGestureRecognizer(gesture)
        self.followersView.addGestureRecognizer(gesture2)
        self.allview.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+100)
        getProfileInfo();
        }
    override func viewDidAppear(_ animated: Bool) {
        
    }
    func showInfo() {
        
        DispatchQueue.main.async{
            
            self.lblName.text = self.getFName + " " + self.getLName
            self.lblPlace.text = self.getCity
            self.lblrole.text = self.getRole
            if(self.getOwner==self.profileId){
                self.isOwner = true
        }else{
                self.isOwner = false
        }
            if(self.isOwner){
                self.btnFirst.setTitle("New Collection", for: .normal)
                self.btnSecond.setTitle("New Clue", for: .normal)
            
            
        }else{
                self.btnSetting.setTitleColor(.white, for: .normal)
                self.btnEdit.setTitleColor(.white, for: .normal)
            //btnEdit.isHidden=true
            self.loadViewIfNeeded()
                self.btnFirst.setTitle("send Message", for: .normal)
                self.btnFirst.backgroundColor = .white
                self.btnFirst.layer.cornerRadius = 5
                self.btnFirst.layer.borderWidth = 1
                self.btnFirst.layer.borderColor = UIColor.purple.cgColor
                if(self.followedByMe==1){
                    self.btnSecond.setTitle("Following", for: .normal)
            }else{
                    self.btnSecond.setTitle("Follow", for: .normal)
            }
                
                self.btnSecond.backgroundColor = UIColor.init(red: 66/256, green: 129/256, blue: 191/256, alpha: 1.0)
                self.btnSecond.isHidden = true
                self.activitiesView.isHidden = true
        
                self.view.layoutIfNeeded()
                self.loadViewIfNeeded()
                

               
        }
        
            self.indicator.isHidden = true
            if(self.getImage != ""){
                let url = URL(string: self.getImage)
            
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgProfile.image = image
                            self?.imgProfile.layer.cornerRadius = (self?.imgProfile.layer.frame.size.width)!/2
                            self?.imgProfile.clipsToBounds = true
                        }
                    }
                }
            }
        }
        
        
        
        
        
            if(self.bio==""){
                self.lblBio.text = self.getFName + " " + self.getLName + " is using MyCareerClue to share their valuable experiences. To see Clues, Collections and Resources, please swipe left."
        }else{
                self.lblBio.text =  self.bio
        }
        
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
            self.imgProfile.isUserInteractionEnabled = true
            self.imgProfile.addGestureRecognizer(tapGestureRecognizer)
            self.allview.isHidden = false
        }
        holeView.isHidden = false
    }
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    func getProfileInfo()  {
        
            holeView.isHidden = true
            WebCaller.userInfo(getOwner, profileId)
            {
                (contents, error) in
                if let error = error{
                    self.updateError()
                    print(error)
                    return
                }
                guard let content = contents else{
                    self.updateError()
                    print("error getting collections")
                    return
                }
                self.updateUI(content: content)
            }
        
        
    }
    @IBOutlet weak var holeView: UIView!
    func updateUI(content : UserInfo){
        DispatchQueue.main.async{
            
            self.bio = content.bio
           // self.getFName = content.userName
            //self.getLName = ""
            self.getCity = content.location
            self.getRole = content.education
            self.getImage = content.photo
            self.lblSaves.text = String(content.likesCount)
            self.lblBuys.text = String(  content.purchasedCount)
            self.lblFollowers.text  = String(content.followingCount)
            
            self.showInfo()
            
            SVProgressHUD.dismiss()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if(getOwner == profileId){
            let userDefaults = UserDefaults.standard
            let name = userDefaults.value(forKey: "fName") as! String
            let lName = userDefaults.value(forKey: "lName") as! String
            let city = userDefaults.value(forKey: "City") as! String
            let job = userDefaults.value(forKey: "job") as! String
            let bio = userDefaults.value(forKey: "bio") as! String
            lblBio.text = bio
            
            

            lblrole.text = job
            lblName.text = name + " " + lName
            lblPlace.text = city
            
        }
        
    }
   
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let fullscreen = storyBoard.instantiateViewController(withIdentifier: "fullscreen") as! fullScreenImageVC
        fullscreen.imgAddress = getImage
        self.present(fullscreen,animated: true,completion: nil)
    }
    
   
}





