//
//  HomeVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/22/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var isOpenMenu = false
    @IBAction func menuBtn(_ sender: Any) {
        if(isOpenMenu){
            menuWidth.constant = 0
            UIView.animate(withDuration: 0.4,animations : {
                self.view.layoutIfNeeded()
            })
        }else{
            menuWidth.constant = 240
            UIView.animate(withDuration: 0.4,animations : {
                self.view.layoutIfNeeded()
            })
        }
        isOpenMenu  = !isOpenMenu
    }
    @IBAction func btnClose(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let splash = storyBoard.instantiateViewController(withIdentifier: "splash") as! SplashCV
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        self.present(splash, animated: true, completion: nil)
        
    }
    @IBOutlet weak var menu: UIView!
    @IBOutlet weak var imgProfile: UIButton!
    @IBOutlet weak var menuWidth: NSLayoutConstraint!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getContent().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeCell {
            cell.updateView(content: DataService.instance.getContent()[indexPath.row])
            return cell
        }else{
            return HomeCell()
        }
    }
    

    @IBOutlet weak var homeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTable.dataSource = self
        homeTable.delegate = self
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        
        let userDefaults = UserDefaults.standard
        var Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
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
        // Do any additional setup after loading the view.
    }


    
    
    
}
