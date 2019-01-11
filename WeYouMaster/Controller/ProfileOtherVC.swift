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

    
    
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    
    @IBOutlet weak var btnSetting : UIButton!

     @IBOutlet weak var btnEdit : UIButton!
    @IBOutlet weak var btnFirst : UIButton!
    @IBOutlet weak var btnSecond : UIButton!
    
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    
    @IBAction func firstButtonClicked(_ sender: Any) {
        if(!isOwner){
            let userDefaults = UserDefaults.standard
            userDefaults.set(getName, forKey: "lastname")
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let sendPm = storyBoard.instantiateViewController(withIdentifier: "sendPm") as! SendPmVC
            
            self.present(sendPm, animated: true, completion: nil)
            
        }else{
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detail = storyBoard.instantiateViewController(withIdentifier: "addCollection") as! AddCollectionVC
            
            self.present(detail, animated: true, completion: nil)
        }
    }
    
    var getName = String()
    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var followedByMe = Int()
    var getOwner = String()
    var bio = String()
    var isOwner : Bool!
    
    @IBAction func btnLikeOrNew(_ sender: Any) {
        if(getOwner==profileId){
            // is new post
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let add = storyBoard.instantiateViewController(withIdentifier: "selectContributeType") as! SelectContriButeType
            let userDefaults = UserDefaults.standard
            userDefaults.set("0", forKey: "selectedCollection")
            self.present(add, animated: true, completion: nil)
        }else{
            SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")

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

                    self.btnSecond.setTitle("رصد کن", for: .normal)
                    }
                }else{
                    DispatchQueue.main.async{
                        SVProgressHUD.dismiss()

                        self.followedByMe = 1
                    self.btnSecond.setTitle("درحال رصد", for: .normal)
                    }
                }
            }
        }
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title : "پروفایل")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = getName
        lblPlace.text = getCity
        lblrole.text = getRole
        if(getOwner==profileId){
            isOwner = true
        }else{
            isOwner = false
        }
        if(isOwner){
            btnFirst.setTitle("مجموعه جدید", for: .normal)
            btnSecond.setTitle("مشارکت جدید", for: .normal)
            
            
        }else{
            btnSetting.isHidden=true
            btnEdit.isHidden=true
            loadViewIfNeeded()
            btnFirst.setTitle("درخواست مشاوره", for: .normal)
            
            if(followedByMe==1){
                btnSecond.setTitle("در حال رصد", for: .normal)
            }else{
                btnSecond.setTitle("رصد کن", for: .normal)
            }
            btnSecond.backgroundColor = UIColor.init(red: 66/256, green: 129/256, blue: 191/256, alpha: 1.0)
        }
       
        indicator.isHidden = true
        if(getImage != ""){
        let url = URL(string: getImage)
        
        
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
        
        
        
        

        if(bio==""){
            lblBio.text = getName + " از ویومستر جهت به اشتراک گذاشتن تجارب ارزشمند خود استفاده خواهد کرد. در صورتیکه تمایل دارید جدیدترین و بروزترین ها را دریافت کنید ، لطفا بر روی گزینه رصد کن کلیک نمایید."
        }else{
            lblBio.text =  bio
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        imgProfile.isUserInteractionEnabled = true
        imgProfile.addGestureRecognizer(tapGestureRecognizer)
        
        
}
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
      
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let fullscreen = storyBoard.instantiateViewController(withIdentifier: "fullscreen") as! fullScreenImageVC
        fullscreen.imgAddress = getImage
        self.present(fullscreen,animated: true,completion: nil)
    }
   
}





