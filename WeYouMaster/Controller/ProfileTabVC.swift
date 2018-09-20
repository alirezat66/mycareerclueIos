//
//  ProfileTabVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/19/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip
class ProfileTabVC: ButtonBarPagerTabStripViewController {
    
    
    var getName = String()
    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var followedByMe = Int()
    var getOwner = String()
    var bio = String()
    let purpleInspireColor = UIColor(red:0.13, green:0.03, blue:0.25, alpha:1.0)

    override func viewDidLoad() {
        
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .black
            newCell?.label.textColor = self?.purpleInspireColor
        }
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        moveToViewController(at: 2)
        // Do any additional setup after loading the view.
    }

   
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        
     
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
        
        
        profile.getName = getName
        profile.getCity = getCity
        profile.getRole = getRole
        
        profile.getImage = getImage
        profile.followedByMe = followedByMe
        profile.profileId = profileId
        profile.getOwner = getOwner
        profile.bio = bio
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(profileId, forKey: "otherUser")
        
        let child_1 = profile
        let child_2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "likeOthers")
        let child_3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionOtherVC")
      let child_4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeOtherVC")
        return [child_2,child_3,child_4,child_1]
    
    }
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
