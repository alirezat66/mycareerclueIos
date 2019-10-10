//
//  LogInVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/17/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import OneSignal
extension UITextField {
    func isError(baseColor: CGColor, numberOfShakes shakes: Float, revert: Bool) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
}
class LogInVC: UIViewController {
    let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)

     let alertController = UIAlertController(title: nil, message: "please wait...\n\n", preferredStyle: .alert)
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPass: UITextField!
    @IBOutlet weak var myView: UIView!
    @IBAction func backBtn(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let signInVc = storyBoard.instantiateViewController(withIdentifier: "SignInPage") as! SignInVC
        self.present(signInVc, animated: true, completion: nil)
    }
    @IBAction func btnForgetPass(_ sender: Any) {
        guard let url = URL(string: "https://mycareerclue.com/reset") else {
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
     //   setborder(myTextField: edtEmail)
    //    setborder(myTextField: edtPass)
        // Do any additional setup after loading the view.
    }

    
    func startLoading() {
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
    }
    func dissmissLoading(){
        self.alertController.dismiss(animated: true, completion: nil);
    }
    @IBAction func btnLogin(_ sender: Any) {
      
        if((edtEmail.text?.count)!>0){
            if((edtPass.text?.count)!>0){
                  let email = edtEmail.text
                  let pass = edtPass.text
                
              startLoading()
                getLogin(email!, pass!,self)
                
            
                
            
                
            }else{
                edtPass.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            }
        }else {
            edtEmail.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
        }
    }

func getLogin(_ email: String,_ pass : String,_ myVc : LogInVC) {
    
    
        
    
        WebCaller.getLogin(email,pass, completionHandler: { (todo, error) in
            if error != nil {
               
                // got an error in getting the data, need to handle it
                DispatchQueue.main.async{
                     self.dissmissLoading()
                    Utility.showToast(message: "username or password is wrong!", myView: self.myView)
                }
                return
            }
            guard let todo = todo else {
                
                DispatchQueue.main.async{
                    self.dissmissLoading()
                    Utility.showToast(message: "username or password is wrong!", myView: self.myView)
                }
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
                userDefaults.set(todo.bio, forKey: "bio")
                userDefaults.set(todo.Sold_sofar, forKey: "sales")
                userDefaults.set(todo.LinkedIn, forKey: "linkedIn")
                userDefaults.set(3, forKey: "loginState")
                userDefaults.set(todo.planStatus, forKey: "planStatus")
                userDefaults.set(todo.user_key , forKey: "user_key")
                
                OneSignal.setEmail(todo.Email)
                
                let tags: [AnyHashable : Any] = [
                    "owner" : todo.Owner
                ]
                OneSignal.sendTags(tags)
                let home = StoryBoard.instantiateViewController(withIdentifier: "BaseBar" ) as? BaseTabBarController
                print("3")
                self.alertController.dismiss(animated: true, completion: nil);
                self.present(home!, animated: true, completion: nil)
            }
            

            // success :)
            
          
            
        })
    

    }
    
    func setborder(myTextField : UITextField ) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.frame.height, width: myTextField.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.white.cgColor
        myTextField.borderStyle = UITextBorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
        
    }

}
