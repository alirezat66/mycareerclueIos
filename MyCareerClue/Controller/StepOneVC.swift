//
//  StepOneVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/9/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class StepOneVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    public var name : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
         let userDefaults = UserDefaults.standard
        let name = userDefaults.string(forKey: "name")
        lblName.text = name
        // Do any additional setup after loading the view.
    }

  
    

    

}
