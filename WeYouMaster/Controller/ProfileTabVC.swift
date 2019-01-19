//
//  ProfileTabVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/19/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import JJFloatingActionButton
class ProfileTabVC: ButtonBarPagerTabStripViewController {
    
    
    var getFName = String()
    var getLName = String()

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
        
        if(profileId==getOwner){
        let actionButton = JJFloatingActionButton()
        
        actionButton.addItem(title: "مجموعه جدید", image: UIImage(named: "edit.png")?.withRenderingMode(.alwaysTemplate)) { item in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let detail = storyBoard.instantiateViewController(withIdentifier: "addCollection") as! AddCollectionVC
            
            self.present(detail, animated: true, completion: nil)
            // do something
        }
        
        actionButton.addItem(title: "فصل جدید", image: UIImage(named: "edit.png")?.withRenderingMode(.alwaysTemplate)) { item in
            // do something
            let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
            let newChapter = StoryBoard.instantiateViewController(withIdentifier: "addChapter")
            self.present(newChapter, animated: true, completion: nil)
            
        }
            
        
        actionButton.addItem(title: "مشارکت جدید", image: UIImage(named: "edit.png")?.withRenderingMode(.alwaysTemplate)) { item in
            // do something
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let add = storyBoard.instantiateViewController(withIdentifier: "selectContributeType") as! SelectContriButeType
            let userDefaults = UserDefaults.standard
            userDefaults.set("0", forKey: "selectedCollection")
            self.present(add, animated: true, completion: nil)
            
        }
        
        view.addSubview(actionButton)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        }
        
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
        
        
        profile.getFName = getFName
        profile.getLName = getLName
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
