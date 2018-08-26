//
//  AddFeedVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/26/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
class AddFeedVC: UIViewController, UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblDate : UILabel!
    @IBOutlet weak var publicSwitch: UISwitch!
    @IBOutlet weak var rtlSwitch: UISwitch!
    var publicType  = 1
    var rtl = 1
    var type  = 0
    @IBOutlet weak var edtTitle : UITextField!
    @IBOutlet weak var edtLink : UITextField!
    @IBOutlet weak var edtAparat : UITextField!
    @IBOutlet weak var edtYoutube : UITextField!

    @IBAction func publicToggleChange(_ sender: Any) {
        if publicSwitch.isOn {
            publicType = 1
        }
        else
        {
            publicType = 0
        }
    }
    @IBAction func rtlToggleChange(_ sender: Any) {
        if rtlSwitch.isOn {
            rtl = 1
        }
        else
        {
            rtl = 0
        }
    }
    @IBOutlet weak var edtDesc : UITextView!
    @IBAction func btnSave(_ sender: Any) {
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        
        
        WebCaller.saveFeed(owner: Owner, location: City, publicState: publicType, align: rtl, contentType: type, collectionId: 0, title: edtTitle.text!, description: edtDesc.text, link: edtLink.text!, apparatLink: edtAparat.text!, youtubeLink: edtYoutube.text!, insertTimeStamp: milliseconds){
            (myResp,error) in
            if let error = error {
                print(error)
                return
            }
            guard let resp = myResp else {
                print("error getting ")
                return
            }
            if(resp.error == 0){
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }else{
                SVProgressHUD.dismiss()
                self.dismiss(animated: true, completion: nil)
                Utility.showToast(message: resp.errorMessage, myView: self.view)
                 self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func btnDropType(_ sender: Any) {
        if(!isOpen){
            UIView.animate(withDuration: 0.5){
                self.isOpen = true
                self.tableType.isHidden = false
                self.tableCat.isHidden = true
                self.isOpenCat = false
            }
        }
    }
    @IBAction func btnCatAct(_ sender: Any) {
        if(!isOpenCat){
            UIView.animate(withDuration: 0.5){
                self.isOpenCat = true
                self.tableCat.isHidden = false
                self.tableType.isHidden = true
                self.isOpen = false
            }
        }
    }
    @IBOutlet weak var btnCat: UIButton!
    @IBOutlet weak var tableCat: UITableView!
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableType){
        return typeList.count
        }else{
            return catList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?

        if(tableView == self.tableType){
         cell = tableView.dequeueReusableCell(withIdentifier: "cell",for : indexPath)
            cell?.textLabel?.text = typeList[indexPath.row]
       
        }else if(tableView == self.tableCat){
             cell = tableView.dequeueReusableCell(withIdentifier: "celltwo",for : indexPath)
            cell?.textLabel?.text = catList[indexPath.row]
            
        }
        return cell!
    }
    

    var isOpen = false
    var isOpenCat = false
    @IBOutlet weak var tableType: UITableView!
    @IBOutlet weak var btnDropDown: UIButton!
    var typeList = ["آموزش","تجزیه و تحلیل","کتاب","الگو","معرفی شرکت","معرفی ابزار","سایر"]
    var catList = ["cat1","cat2","cat3"]
    
    var Owner: String = "" 
    var First_Name: String = ""
    var Last_Name: String = ""
   
    var Job_Position : String = ""
    var City : String = ""
    var Profile_photo_link : String = ""
   
    
    var milliseconds: Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableType.delegate = self
        tableType.dataSource = self
        tableType.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        tableType.isHidden = true
        tableCat.delegate = self
        tableCat.dataSource = self
        tableCat.register(UITableViewCell.self, forCellReuseIdentifier: "celltwo")
        tableCat.isHidden = true

        imgProfile.layer.cornerRadius = imgProfile.layer.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        // make ui
        
        let userDefaults = UserDefaults.standard
        Owner = userDefaults.value(forKey: "owner") as! String
        First_Name = userDefaults.value(forKey: "fName") as! String
        Last_Name = userDefaults.value(forKey: "lName") as! String
        Job_Position = userDefaults.value(forKey: "job") as! String
        City = userDefaults.value(forKey: "City") as! String
        Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        
        
        lblName.text = First_Name + " " + Last_Name
        lblrole.text = Job_Position
        lblPlace.text = City
        let url = URL(string: Profile_photo_link)
        
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imgProfile.image = image
                    }
                }
            }
        }
        
        
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.calendar = Calendar(identifier: .gregorian)
        let date = Date()
        let dateInGrogrian = formatter.string(from: date)
        
        print(dateInGrogrian)
        
        formatter.calendar = Calendar(identifier: .persian)
        formatter.dateFormat = "yyyy/MM/dd"
        lblDate.text = formatter.string(from: date)
       milliseconds = Int64(date.timeIntervalSince1970)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(tableView == tableType){
        UIView.animate(withDuration: 0.2){
        self.btnDropDown.setTitle(self.typeList[indexPath.row], for: .normal)
            self.isOpen = false
            self.tableType.isHidden = true
            self.view.layoutIfNeeded()
            self.type = indexPath.row
            
        }
        }else{
            UIView.animate(withDuration: 0.2){
                self.btnCat.setTitle(self.catList[indexPath.row], for: .normal)
                self.isOpenCat = false
                self.tableCat.isHidden = true
                self.view.layoutIfNeeded()
                
            }
        }
    }
    




    
    
}


