//
//  LockVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class LockVC: UIViewController {
    
    @IBOutlet weak var imgOne: UIImageView!
    @IBOutlet weak var imgTwo: UIImageView!
    @IBOutlet weak var imgThree: UIImageView!
    
    @IBOutlet weak var imgFour: UIImageView!
    @IBOutlet weak var imgFive: UIImageView!
    
    
    
    
    var TIMER  = Timer()
    var verCode : String = ""
    var Seconds = 60
    
    
    @IBOutlet weak var lblSecond: UILabel!
    @IBAction func sendAgainBtn(_ sender: Any) {
        Seconds = 60
        btnOutlet.isHidden = true
       

        TIMER = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LockVC.Clock), userInfo: nil, repeats: true)
        lblTime.isHidden  = false
        lblSecond.isHidden = false
        self.view.layoutIfNeeded()
        
    }
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    public var stringPassed = ""
    @IBOutlet weak var btnOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblNumber.text = stringPassed
        btnOutlet.isHidden = true
        TIMER = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(LockVC.Clock), userInfo: nil, repeats: true)
        

    }

    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion:nil)
    }
    @IBAction func pushNumber(sender: AnyObject) {
    guard let button = sender as? UIButton else {
    return
    }
        var str : String = ""
        str = String(button.tag)
        if(button.tag != 10){
            if(verCode.count != 5){
                verCode  = verCode + str
            }
        }else {
            if(verCode.count > 0 ){
                verCode = String(verCode.dropLast())
            }
        }
        
        if(verCode.count == 5){
            if(verCode == "12345"){
                let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
                let userDefaults = UserDefaults.standard
                userDefaults.set(1, forKey: "loginState")
                userDefaults.set(stringPassed, forKey: "phone")
                let profile = StoryBoard.instantiateViewController(withIdentifier: "profilePage" ) as? ProfileVC
                self.present(profile!, animated: true, completion: nil)
            }else{
                verCode  = ""
                showToast(message: "code is wrong")
            }
        }
        managePager(count: UInt32(verCode.count))
        
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    func managePager(count : UInt32)  {
        
        if(count>0 ){
            imgOne.image = UIImage.init(named: "filled-circle")
        }else{
            imgOne.image = UIImage.init(named: "circle-outline")

        }
        if(count>1){
            imgTwo.image = UIImage.init(named: "filled-circle")
        }else{
            imgTwo.image = UIImage.init(named: "circle-outline")
        }
        if(count > 2){
            imgThree.image = UIImage.init(named: "filled-circle")

        }else{
            imgThree.image = UIImage.init(named: "circle-outline")

        }
        if(count > 3){
             imgFour.image = UIImage.init(named: "filled-circle")
        }else{
            imgFour.image = UIImage.init(named: "circle-outline")

        }
        if(count > 4 ){
            imgFive.image = UIImage.init(named: "filled-circle")

        }else{
            imgFive.image = UIImage.init(named: "circle-outline")

        }
    }
    @objc func Clock() {
        Seconds = Seconds-1
        lblTime.text = String(Seconds)
        if Seconds==0 {
            lblTime.isHidden  = true
            lblSecond.isHidden = true
            btnOutlet.isHidden = false
            self.view.layoutIfNeeded()
            TIMER.invalidate()
        }
    }

    

}
