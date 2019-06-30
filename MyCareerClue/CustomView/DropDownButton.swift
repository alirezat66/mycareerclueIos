//
//  DropDownButton.swift
//  WeYouMaster
//
//  Created by alireza on 8/26/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class DropDownButton: UIButton {
    var dropDown = DropDownView()
    var height = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.darkGray
        dropDown = DropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    override func didMoveToSuperview() {
        self.superview?.addSubview(dropDown)
        self.bringSubview(toFront: dropDown)
        dropDown.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        dropDown.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        dropDown.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        height = dropDown.heightAnchor.constraint(equalToConstant: 0)
        
    }
    var isOpen = false
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isOpen == false {
            isOpen = true
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 150
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration : 0.5 ,
                           delay : 0 , usingSpringWithDamping :0.5,
                           initialSpringVelocity: 0.5 ,options: .curveEaseInOut,animations : {
                            self.dropDown.layoutIfNeeded()
            },completion : nil)
            
        }else{
            isOpen = false
            
            NSLayoutConstraint.deactivate([self.height])
            self.height.constant = 0
            NSLayoutConstraint.activate([self.height])
            
            UIView.animate(withDuration : 0.5 ,
                           delay : 0 , usingSpringWithDamping :0.5,
                           initialSpringVelocity: 0.5 ,options: .curveEaseInOut,animations : {
                            self.dropDown.layoutIfNeeded()
            },completion : nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
