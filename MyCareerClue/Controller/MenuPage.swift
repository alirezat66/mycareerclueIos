//
//  MenuPage.swift
//  WeYouMaster
//
//  Created by alireza on 8/27/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class MenuPage: UIViewController {

    @IBOutlet weak var aboutUs : UIStackView!
    @IBOutlet weak var qaStack : UIStackView!

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnExit(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let splash = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashCV
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        self.present(splash, animated: true, completion: nil)
    }
    @IBAction func callToUsBtn(_ sender: Any) {
       
        UIApplication.shared.open(URL(string: "https://www.t.me/shafiei83")!, options: [:])

    }
    
    
    
    @objc func about(sender:UITapGestureRecognizer){
        let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
        
        let aboutPage = StoryBoard.instantiateViewController(withIdentifier: "About" ) as? AboutUsVC
        self.present(aboutPage!, animated: true, completion: nil)
        // do other task
    }
    @objc func qa(sender:UITapGestureRecognizer){
        let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
        
        let qaPage = StoryBoard.instantiateViewController(withIdentifier: "QA" ) as? QAVC
        self.present(qaPage!, animated: true, completion: nil)
        // do other task
    }
    override func viewDidLoad() {
        
        //let gesture = UITapGestureRecognizer(target: self, action: Selector(("about:")))
        //let gesture2 = UITapGestureRecognizer(target: self, action: Selector(("qa:")))
       // self.aboutUs.addGestureRecognizer(gesture)
       // self.qaStack.addGestureRecognizer(gesture2)
        
    }

}
