//
//  StripeViewController.swift
//  WeYouMaster
//
//  Created by AliReza Taghizadeh on 6/20/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import Stripe
class StripeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPay(_ sender: Any) {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
       /*let cardParams = STPCardParams()
        cardParams.number = "4242424242424242"
        cardParams.expMonth = 02
        cardParams.expYear = 2021
        cardParams.cvc = "123"
        
        
        STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
            guard let token = token, error == nil else {
                print(error)
                // Present error to user...
                return
            }
            
           print(token)
        }*/
    }
    
    
    
    

}
