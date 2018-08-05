//
//  ViewController.swift
//  WeYouMaster
//
//  Created by alireza on 7/16/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

   
    @IBOutlet weak var edtMob: UITextField!
    @IBAction func getVerifCode(_ sender: Any) {
        let num : String = edtMob.text!
        let StoryBoard   = UIStoryboard(name: "Main", bundle: nil)
        let lockVC = StoryBoard.instantiateViewController(withIdentifier: "lockpage" ) as? LockVC
        lockVC?.stringPassed = num
        print("salam")
        self.present(lockVC!, animated: true, completion: nil)
        //    self.navigationController?.pushViewController(lockVC!, animated: true)
      //  performSegueWithIdentifier("mySegue", sender: nil)

        edtMob.text = "09"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    

    @IBAction func onBackFromLogin(unwindSegue:UIStoryboardSegue){
       

    }
   
}

