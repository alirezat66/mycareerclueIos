//
//  PaymentViewController.swift
//  WeYouMaster
//
//  Created by AliReza Taghizadeh on 6/20/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import Stripe
import SVProgressHUD

class PaymentViewController: UIViewController {

    
    var getCurrency = String()
    var getFaCurrency = String()
    var getPrice = String()
    var getCollectionId = String ()
    var getCollectionOwner = String()
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtCard: UITextField!
    @IBOutlet weak var edtMonth: UITextField!
    @IBOutlet weak var edtYear: UITextField!
    @IBOutlet weak var edtCVC: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imgStore.layer.cornerRadius = imgStore.layer.frame.width/2
        imgStore.clipsToBounds = true
        btnPay.setTitle("Pay " + getPrice + " " + getCurrency,for: .normal)
        // Do any additional setup after loading the view.
    }

    
    @IBOutlet weak var btnPay: UIButton!
    
    @IBAction func btnPay(_ sender: Any) {
        let cardParams = STPCardParams()
        
        cardParams.number = edtCard.text
        if(edtCard.text!.count != 16){
            edtCard.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        if (edtMonth.text!.count == 0){
             edtMonth.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        if(edtYear.text!.count != 4){
            edtYear.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            return
        }
        if(edtCVC.text!.count != 3){
            edtCVC.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            return
        }
       
        let month:UInt? = UInt(edtMonth.text!)
        let year:UInt? = UInt(edtYear.text!)
        if (month == nil && year == nil){
            if(month == nil){
            edtYear.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
            return
            }else{
                edtMonth.isError(baseColor: UIColor.red.cgColor, numberOfShakes: 3, revert: true)
                return
            }
        }else{
            cardParams.expMonth = month!
            cardParams.expYear = year!
            cardParams.cvc = edtCVC.text
            cardParams.number = edtCard.text
            SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
            STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
                guard let token = token, error == nil else {
                 self.updateError()
                // Present error to user...
                return
                }
                let userDefaults = UserDefaults.standard
                let owner = userDefaults.value(forKey: "owner") as! String
                
                WebCaller.payment(_owner:self.getCollectionOwner, _StripeApiKey: "sk_test_rZMj1B0zWIjNKedp8YdE7FRz", _stripeToken: token.tokenId, _collectionId: self.getCollectionId, _requested_by: "ios", _price: self.getPrice, _cur_en: self.getCurrency, _cur_fa: self.getFaCurrency, _buyer: owner){
                    (normalList,error) in
                    if let error = error{
                        print(error)
                        self.updateError()
                        return
                    }
                    guard let result = normalList else{
                        print("error getting collections")
                        self.updateError()
                        return
                    }

                    self.updateUI(result: result)
                }
                print(token.tokenId)
            }

            
            
            /*self.removeFromParentViewController()
            self.view.removeFromSuperview()*/
        }
        
       
    }
    
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(result : NormalResponse){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
