//
//  ProfileOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ProfileOtherVC: UIViewController , IndicatorInfoProvider{

    
    
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    
    @IBOutlet weak var btnFirst : UIButton!
    @IBOutlet weak var btnSecond : UIButton!
    
    @IBOutlet weak var indicator : UIActivityIndicatorView!
    

    var getName = String()
    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var followedByMe = Int()
    var getOwner = String()
    var bio = String()
    var isOwner : Bool!
    
   
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
            btnFirst.setTitle("درخواست مشاوره", for: .normal)
            btnSecond.setTitle("رصد کن", for: .normal)
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
        
        
}
   
}



