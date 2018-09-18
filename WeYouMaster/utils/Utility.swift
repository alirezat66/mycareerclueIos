//
//  Utility.swift
//  WeYouMaster
//
//  Created by alireza on 8/8/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import Foundation
public class Utility{
    public class func isValidNumber(number : String)->Bool{
        if(number.count>0){
            if(number.count==11){
               return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
    public class func showToast(message : String,myView : UIView) {
        
        let toastLabel = UILabel(frame: CGRect(x: myView.frame.size.width/2 - 125, y: myView.frame.size.height-125, width: 250, height: 75))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "IRANSansMobileFaNum", size: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        myView.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
