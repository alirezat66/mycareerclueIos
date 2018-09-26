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
    
    @IBAction func imgBackAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var lblFree : UILabel!
    @IBOutlet weak var lblPublic : UILabel!
    @IBOutlet weak var lblRtl : UILabel!
    
     @IBOutlet weak var picOne : UIView!
     @IBOutlet weak var picTwo : UIView!
     @IBOutlet weak var picThree : UIView!

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var publicSwitch: UISwitch!
    @IBOutlet weak var freeSwitch: UISwitch!
    @IBOutlet weak var rtlSwitch: UISwitch!
    var publicType  = 1
    var rtl = 1
    var type  = 0
    var free = 1
    @IBOutlet weak var edtTitle : UITextField!

    @IBAction func publicToggleChange(_ sender: Any) {
        if publicSwitch.isOn {
            publicType = 1
            lblPublic.text = "عمومی"
        }
        else
        {
            publicType = 0
            lblPublic.text = "خصوصی"

        }
    }
    @IBAction func rtlToggleChange(_ sender: Any) {
        if rtlSwitch.isOn {
            rtl = 1
            lblRtl.text = "فارسی"
        }
        else
        {
            lblRtl.text = "انگلیسی"
            rtl = 0
        }
    }
    @IBAction func freeSwitch(_ sender: Any) {
        if rtlSwitch.isOn {
            free = 1
            lblFree.text = "رایگان"
        }
        else
        {
            lblFree.text = "فروشی"
            free = 0
        }
    }
    @IBOutlet weak var edtDesc : UITextView!
    @IBOutlet weak var stack : UIStackView!
    @IBAction func btnSave(_ sender: Any) {
    
        
       
        
    }
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
    @IBAction func btnDropType(_ sender: Any) {
        if(!isOpen){
            UIView.animate(withDuration: 0.5){
                self.isOpen = true
                self.tableType.isHidden = false
                self.isOpenCat = false
                self.constraint.constant = 250
                self.stack.layoutIfNeeded()
            }
        }
    }
   

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == self.tableType){
        return typeList.count
        }else{
            return catList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?

         cell = tableView.dequeueReusableCell(withIdentifier: "cell",for : indexPath)
            cell?.textLabel?.text = typeList[indexPath.row]
       
        
        return cell!
    }
    

    var isOpen = false
    var isOpenCat = false
    @IBOutlet weak var tableType: UITableView!
    @IBOutlet weak var btnDropDown: UIButton!
    var typeList=[""]
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

        picOne.layer.cornerRadius = picOne.layer.frame.width/2
        picOne.clipsToBounds = true
        
        picTwo.layer.cornerRadius = picOne.layer.frame.width/2
        picTwo.clipsToBounds = true
        
        picThree.layer.cornerRadius = picOne.layer.frame.width/2
        picThree.clipsToBounds = true
        
        tableType.isHidden = true
        

        imgProfile.layer.cornerRadius = imgProfile.layer.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        // make ui
        
        let userDefaults = UserDefaults.standard
        Owner = userDefaults.value(forKey: "owner") as! String
        Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        
        
       
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
       
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getCloolections()
        
        
        
      
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.tableType.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()            
            
        }
    }
    func getCloolections(){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getCollectionOther(20,1,owner: owner,userId: owner) { (collections , error) in
            if let error = error{
                self.updateError()
                print(error)
                return
            }
            guard let collections = collections else{
                self.updateError()
                print("error getting collections")
                return
            }
            self.typeList.remove(at: 0)
            
            for collect in collections.collections{
                self.typeList.append(collect.Title)
            }
            self.updateUI()
            
            
        }
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.2){
        self.btnDropDown.setTitle(self.typeList[indexPath.row], for: .normal)
            self.isOpen = false
            self.constraint.constant = 50
            self.tableType.isHidden = true
            self.stack.layoutIfNeeded()
            self.type = indexPath.row
            
        
        
        }
    }
    




    
    
}


