//
//  TestCVViewController.swift
//  WeYouMaster
//
//  Created by alireza on 12/3/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import Dropper
import Braintree
import Alamofire
import SwiftyJSON
class TestCVViewController: UIViewController  {
   
    
    @IBOutlet weak var dropdown : UIButton!
    @IBOutlet weak var txtToken : UILabel!
    var brainTreeClient : BTAPIClient?
    @IBAction func btnChose(_ sender: Any) {
        
       /* if dropper.status == .hidden {
            
            dropper.showWithAnimation(0.15, options: .center, position: .bottom, button: dropdown)
            view.addSubview(dropper)
        } else {
            dropper.hideWithAnimation(0.1)
        }*/
    }
//    let dropper = Dropper(width: 75, height: 200)
    @IBOutlet weak var valueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dropdown.isEnabled = false
        Alamofire.request("https://weyoumaster.com/braintree/main.php").responseJSON {
            response in
            if((response.result.value) != nil) {
                let swiftyJsonVar = JSON(response.result.value!)
           
            
                let clientToken = swiftyJsonVar["clientToken"] as! String
                self.dropdown.isEnabled = true
                self.brainTreeClient = BTAPIClient(authorization: clientToken)
                
                
            }
        }
    
     /*   dropper.items = ["Item 1", "Item 2", "Item 3", "Item 4"] // Items to be displayed
        dropper.delegate = self
        dropper.theme = Dropper.Themes.black(nil)
        dropper.cornerRadius = 5*/

    }
    
    
   /* func DropperSelectedRow(_ path: IndexPath, contents: String) {
            valueLabel.text = "Selected Row: \(contents)"
        }*/
    
    
}

