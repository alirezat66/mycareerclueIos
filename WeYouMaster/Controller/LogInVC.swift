//
//  LogInVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/17/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {
    
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPass: UITextField!
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
      
        if((edtEmail.text?.count)!>0){
            if((edtPass.text?.count)!>0){
                  let email = edtEmail.text
                  let pass = edtPass.text
                getLogin(email!, pass!,self)
                
            
                
            
                
            }
        }
    }

func getLogin(_ email: String,_ pass : String,_ myVc : LogInVC) {
        WebCaller.getLogin(email,pass, completionHandler: { (todo, error) in
            if let error = error {
                // got an error in getting the data, need to handle it
                print(error)
                return
            }
            guard let todo = todo else {
                print("error getting first todo: result is nil")
                return
            }
            print("1")
            let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
            
            print("2")
            DispatchQueue.main.async {
                
                
                 let userDefaults = UserDefaults.standard
                 userDefaults.set(todo.Owner, forKey: "owner")
                 userDefaults.set(todo.Email, forKey: "email")
                 userDefaults.set(todo.First_Name, forKey: "fName")
                 userDefaults.set(todo.Industry, forKey: "industry")
                 userDefaults.set(todo.City, forKey: "City")
                 userDefaults.set(todo.Job_Position, forKey: "job")
                 userDefaults.set(todo.Last_Name, forKey: "lName")
                 userDefaults.set(todo.Profile_photo_link, forKey: "profilePhoto")
                userDefaults.set(todo.total_contributions, forKey: "totalPost")
                userDefaults.set(todo.Website, forKey: "webSite")
                userDefaults.set(todo.Sold_sofar, forKey: "sales")
                userDefaults.set(todo.LinkedIn, forKey: "linkedIn")
                userDefaults.set(3, forKey: "loginState")

                let home = StoryBoard.instantiateViewController(withIdentifier: "BaseBar" ) as? BaseTabBarController
                print("3")
                
                self.present(home!, animated: true, completion: nil)
            }
            

            // success :)
            
          
            
        })
    

    }
}
