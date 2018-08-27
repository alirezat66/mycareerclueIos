//
//  MenuPage.swift
//  WeYouMaster
//
//  Created by alireza on 8/27/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class MenuPage: UIViewController {

    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func btnExit(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let splash = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashCV
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        self.present(splash, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        
    }

}
