//
//  ProfileOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class ProfileOtherVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var btnFollowOutlet: UIButton!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var loader : UIActivityIndicatorView!
    var getName = String()
    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var followedByMe = Int()
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func followPressed(_ sender: Any) {
        if(followedByMe==0){
            follow()
        }else{
            unFollow()
        }
    }
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = getName
        lblLocation.text = getCity
        lblRole.text = getRole
        
        profileImage.layer.cornerRadius = profileImage.layer.frame.size.width/2
        profileImage.clipsToBounds = true
        let url = URL(string : getImage)
        loader.startAnimating()
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                self?.loader.startAnimating()
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.profileImage.image = image
                        self?.loader.stopAnimating()
                        
                    }
                }
            }
        }
        if(followedByMe==0){
            btnFollowOutlet.setTitle("رصد کن", for: .normal)
        }else{
            btnFollowOutlet.setTitle("در حال رصد", for: .normal)
        }
    }
    
  
    @IBAction func btnActions(_ sender: Any) {
        
        let userDefaults = UserDefaults.standard
        let a = profileId
        userDefaults.set(profileId, forKey: "otherUser")
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyBoard.instantiateViewController(withIdentifier: "BaseTwo") as! BaseTabBarController
        
        self.present(home, animated: true, completion: nil)
    }
    func follow() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.followDisFollow(0, owner, profileId) { (state, error) in
            if let error = error{
                print(error)
                return
            }
            guard let state = state else{
                print("error getting collections")
                return
            }
            if(state == 1 ){
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.followedByMe  = 1
                    self.btnFollowOutlet.setTitle("در حال رصد", for: .normal)
                    print("follow ok")
                })
                
            }
        }
    }
    
    
    func unFollow() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.followDisFollow(1, owner, profileId) { (state, error) in
            if let error = error{
                print(error)
                return
            }
            guard let state = state else{
                print("error getting collections")
                return
            }
            if(state == 1 ){
                
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.followedByMe  = 0
                    self.btnFollowOutlet.setTitle("رصد کن", for: .normal)
                    print("unFollow ok")

                })
                
            }
        }
    }

}
