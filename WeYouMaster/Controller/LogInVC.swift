//
//  LogInVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/17/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class LogInVC: UIViewController {

    @IBOutlet weak var edtEmail: UITextField!
    @IBOutlet weak var edtPass: UITextField!
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func btnLogin(_ sender: Any) {
      
        if((edtEmail.text?.count)!>0){
            if((edtPass.text?.count)!>0){
                  let email = edtEmail.text
                  let pass = edtPass.text
                
                let myUrl = NSURL(string: "https://www.weyoumaster.com/api/login/")
                var request  = URLRequest(url: myUrl! as URL)
                request.httpMethod = "POST"
                let postString = "emailaddress=" + email! + "&password=" + pass!
                request.httpBody = postString.data(using: String.Encoding.utf8)
               let session = URLSession.shared
               
                let task = session.dataTask(with: request){
                    (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil
                    {
                        print("error=\(error)")
                        return
                    }
                    
                    // You can print out response object
                    print("response = \(response)")
                    
                    //Let's convert response sent from a server side script to a NSDictionary object:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        print(json!)
                     /*   if let parseJSON = json {
                            
                            // Now we can access value of First Name by its key
                            let firstNameValue = parseJSON["firstName"] as? String
                            print("firstNameValue: \(firstNameValue)")
                        }*/
                    } catch {
                        print(error)
                    }
                }
                task.resume()
                
                
                    
                
            }
        }
    }
    

}
