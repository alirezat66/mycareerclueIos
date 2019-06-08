//
//  AlertDedicatedLink.swift
//  WeYouMaster
//
//  Created by alireza on 6/8/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
class AlertDedicatedLink: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var tfDedicatedLink: UITextField!
    
    @IBAction func btnAddDedicatedLink(_ sender: Any) {
        if(tfDedicatedLink.text == ""){
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        }else{
            
            addLink(link: tfDedicatedLink.text ?? "")
        }
        
    }
    
    @IBAction func btnCancelDedicatedLink(_ sender: Any) {
        SVProgressHUD.dismiss()
        
        //self.alertController.dismiss(animated: true, completion: nil);
        
        
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
        
    }
    
    func addLink(link : String){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
       
         SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        WebCaller.addLink(_owner: owner, _link:link){
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
                    self.removeFromParentViewController()
                    self.view.removeFromSuperview()
                    
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
