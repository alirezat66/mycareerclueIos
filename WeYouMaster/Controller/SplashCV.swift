//
//  SplashCV.swift
//  WeYouMaster
//
//  Created by alireza on 8/8/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class SplashCV: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            
            let userDefaults = UserDefaults.standard
            
            if userDefaults.value(forKey: "loginState") != nil {
                let state = userDefaults.integer(forKey: "loginState")
                if(state == 1 ){
                    let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)

                    let profile = StoryBoard.instantiateViewController(withIdentifier: "profilePage" ) as? ProfileVC
                    
                    self.present(profile!, animated: true, completion: nil)
                }else if(state==2){
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let stepOne = storyBoard.instantiateViewController(withIdentifier: "stepOne") as! StepOneVC
                        
                        self.present(stepOne, animated: true, completion: nil)
                    }
                else if( state == 3){
                    let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let home = storyBoard.instantiateViewController(withIdentifier: "BaseBar") as! BaseTabBarController
                    //let home = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
                    self.present(home, animated: true, completion: nil)
                   
                    /*let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                    let home = storyBoard.instantiateViewController(withIdentifier: "collectionDetail") as! CollectionDetailTwoVC
                    
                    self.present(home, animated: true, completion: nil)*/
                    // do something here when a highscore exists
                }
            }
            else {
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let signInVc = storyBoard.instantiateViewController(withIdentifier: "LogIn") as! LogInVC
                self.present(signInVc, animated: true, completion: nil)

            }
        })
        

        // Do any additional setup after loading the view.
    }

   

}
