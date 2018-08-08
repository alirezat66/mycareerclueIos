//
//  StepThreeController.swift
//  WeYouMaster
//
//  Created by alireza on 8/8/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class StepThreeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    var shouldSelect  : Bool = true
    var shouldSelect2 : Bool = true
    var shouldSelect3 : Bool = true
    var shouldSelect4 : Bool = true
    var  shouldSelect5 : Bool = true
    
    
    @IBOutlet weak var btnOne: DLRadioButton!
    @IBOutlet weak var btnTwo: DLRadioButton!
    @IBOutlet weak var btnThree: DLRadioButton!
    @IBOutlet weak var btnFour: DLRadioButton!
    @IBOutlet weak var btnFive : DLRadioButton!
    
    
    @IBAction func btnSave(_ sender: Any) {
        let usD = UserDefaults.standard
         usD.set(3, forKey: "loginState")
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let home = storyBoard.instantiateViewController(withIdentifier: "homeVC") as! HomeVC
        
        self.present(home, animated: true, completion: nil)
    }
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

}
