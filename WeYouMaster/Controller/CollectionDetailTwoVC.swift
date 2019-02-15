//
//  CollectionDetailTwoVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/24/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class CollectionDetailTwoVC: ButtonBarPagerTabStripViewController {
    var getName = String()
    var getDegree = String()
    var getTitle = String()
    var getImage = String()
    var collectionId = String()
    var getStartDate = String()
    var numberOdPost = Int()
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
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

 override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
    
    let about = storyBoard.instantiateViewController(withIdentifier: "colDetail") as! CollectionDetailVCTwo
    
    
    about.getName = getName
    about.getDegree = getDegree
    about.getImage = getImage
    about.collectionId = collectionId
    about.getStartDate = getStartDate
    about.getTitle = getTitle
    let one = about
    
    let collectionFeeds = storyBoard.instantiateViewController(withIdentifier: "CollectionDetailVC") as! CollectionDetailVC
    collectionFeeds.collectionId = collectionId
    let two = collectionFeeds
    let three = storyBoard.instantiateViewController(withIdentifier: "child1") as! Child1VC
    
    let four = storyBoard.instantiateViewController(withIdentifier: "child2") as! Child2VC
        return [three,four,two,one]
    
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.moveToViewController(at: 3, animated: true)
            self.buttonBarView.moveTo(index: 3, animated: true, swipeDirection: .right, pagerScroll: .yes)
        }
    }
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


