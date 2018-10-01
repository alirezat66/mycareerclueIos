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
let purpleInspireColor = UIColor.init(red: 61/256, green: 13/256, blue: 71/256, alpha: 1.0)
    override func viewDidLoad() {
        
        self.settings.style.buttonBarBackgroundColor = UIColor.init(red: 61/256, green: 13/256, blue: 71/256, alpha: 1.0)
        self.settings.style.buttonBarItemBackgroundColor = UIColor.init(red: 61/256, green: 13/256, blue: 71/256, alpha: 1.0)
        buttonBarView.backgroundColor = UIColor(red: 7/255, green: 185/255, blue: 155/255, alpha: 1)
        settings.style.selectedBarBackgroundColor = UIColor.white
        settings.style.buttonBarItemLeftRightMargin = 2
        settings.style.buttonBarItemTitleColor = UIColor.red
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = UIColor.init(red: 235/256, green: 204/256, blue: 241/256, alpha: 1.0)
            newCell?.label.textColor = UIColor.white
        }
        navigationController?.navigationBar.isTranslucent = false
       
        
        super.viewDidLoad()

            // Do any additiona
    }

    override func viewWillAppear(_ animated: Bool) {
         DispatchQueue.main.async {
        self.moveToViewController(at: 3, animated: true)
        self.buttonBarView.moveTo(index: 3, animated: true, swipeDirection: .right, pagerScroll: .yes)
        }
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
        userDefaults.set(getImage, forKey: "otherImage")
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
