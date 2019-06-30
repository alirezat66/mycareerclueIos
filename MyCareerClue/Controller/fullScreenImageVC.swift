//
//  fullScreenImageVC.swift
//  WeYouMaster
//
//  Created by alireza on 1/11/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit

class fullScreenImageVC: UIViewController {
    
    var imgAddress = String()
    
    @IBOutlet weak var uiImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
         let url = URL(string: imgAddress)
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.uiImage.image = image
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
       dismiss(animated: true, completion: nil)
    }
    

}
