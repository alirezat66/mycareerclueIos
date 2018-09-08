//
//  ViewController.swift
//  WeYouMaster
//
//  Created by alireza on 7/16/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

   
    @IBOutlet weak var edtName : UITextField!
    @IBOutlet weak var edtLName : UITextField!

    @IBOutlet weak var edtEmail : UITextField!

    @IBOutlet weak var edtPassword : UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setborder(myTextField: edtName)
        setborder(myTextField: edtLName)
        setborder(myTextField: edtEmail)
        setborder(myTextField: edtPassword)
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setborder(myTextField : UITextField ) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: myTextField.frame.height, width: myTextField.frame.width-2, height: 2)
      
        bottomLine.backgroundColor = UIColor.white.cgColor
        myTextField.borderStyle = UITextBorderStyle.none
        myTextField.layer.addSublayer(bottomLine)
    
    }

    

    
   
}

