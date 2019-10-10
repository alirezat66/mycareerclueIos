//
//  AlartPriceVC.swift
//  WeYouMaster
//
//  Created by alireza on 3/29/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class AlartPriceVC: UIViewController {
    
    var getTitle = String()
     var collectionId = String()
    @IBOutlet weak var btnOne: DLRadioButton!
    @IBOutlet weak var btnTwo: DLRadioButton!
    @IBOutlet weak var btnThree: DLRadioButton!
    @IBOutlet weak var btnFour: DLRadioButton!
    @IBOutlet weak var btnFive : DLRadioButton!
    
    @IBOutlet weak var lblTitr: UILabel!
    
    @IBOutlet weak var edtPrice: UITextField!
    var shouldSelect  : Bool = true
    var shouldSelect2 : Bool = true
    var shouldSelect3 : Bool = true
    var shouldSelect4 : Bool = true
    var  shouldSelect5 : Bool = true
    
    @IBAction func pressBtnTwo(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.btnTwo.isSelected = self.shouldSelect2
            self.shouldSelect2 = !self.shouldSelect2
        }
    }
    
    @IBAction func pressBtnOne(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.btnOne.isSelected = self.shouldSelect
            self.shouldSelect = !self.shouldSelect
        }
    }
    
    @IBAction func pressBtnThree(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.btnThree.isSelected = self.shouldSelect3
            self.shouldSelect3 = !self.shouldSelect3
        }
    }
    @IBAction func pressBtnFour(_ sender : Any){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.btnFour.isSelected = self.shouldSelect4
            self.shouldSelect4 = !self.shouldSelect4
        }
    }
    @IBAction func pressBtnFive(_ sender : Any ){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1){
            self.btnFive.isSelected = self.shouldSelect5
            self.shouldSelect5 = !self.shouldSelect5
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lblTitr.text = "Set price for " + getTitle
        // Do any additional setup aftت گذاری مجموعهer loading the view.
    }
    

    @IBAction func btnCancel(_ sender: Any) {
        
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
       
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
        
    }
    @IBAction func btnSubmit(_ sender: Any) {
        if(edtPrice.text == ""){
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        }else{
             checkPrice()
        }
      
    }
    func checkPrice() {
        var currency = ""
        if(btnOne.isSelected){
            currency = "aud"
        }else if (btnTwo.isSelected){
            currency = "cad"
        }else if (btnThree.isSelected){
            currency = "eur"
        }else if (btnFour.isSelected){
            currency = "usd"
        }else {
            currency = "irr"
        }
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        SVProgressHUD.show(withStatus: " Please Wait ... \n\n")
        WebCaller.addPrice(_owner: owner, _collectionId: collectionId, _price: edtPrice.text!, _currency: currency, _desc:  "from add price"){
            (answer, error) in
            if let error = error{
                print(error)
                return
            }
            guard let answer = answer else{
                DispatchQueue.main.async{
                    SVProgressHUD.dismiss()
                    
                    //self.alertController.dismiss(animated: true, completion: nil);
                    
                }
                print("error getting labeles")
                return
            }
            
            if(answer.error==0){
                 DispatchQueue.main.async{
                SVProgressHUD.dismiss()
                self.removeFromParentViewController()
                self.view.removeFromSuperview()
                }
               
                
            }else{
                 DispatchQueue.main.async{
                    SVProgressHUD.dismiss()

                }
            }
            
            
        }
        
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
