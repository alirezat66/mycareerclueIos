//
//  SaverOfContributeVC.swift
//  WeYouMaster
//
//  Created by alireza on 6/8/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class SaverOfContributeVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    var myResult : [SaverResp] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResult.count
    }
    var getContributionId = String()
    var getOwner  = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTabelSavers.dataSource = self
        uiTabelSavers.delegate = self
        getList();
        // Do any additional setup after loading the view.
    }
    func getList(){
         myResult.removeAll()
           SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
       
        WebCaller.saverOfContributionList(getOwner,getContributionId) {
            (searchList, error) in
            if let error = error{
                print(error)
                self.updateError()
                return
            }
            guard let searchList = searchList else {
                self.updateError()
                print("error getting search list")
                return
            }
            for search in searchList.records{
                self.myResult.append(search)
            }
            self.updateUI()
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.uiTabelSavers.reloadData()
            
            //  self.goToLast()
            
            SVProgressHUD.dismiss()
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(myResult.count>=indexPath.row){
            let search = myResult[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "saverCell") as? SaverCell{
                
                cell.updateView(search: search)
                return cell
            }else{
                return SaverCell()
            }
        }
        else{
            return  SaverCell()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = myResult[indexPath.row]
        
        
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            
            profile.getFName = obj.saver_name
            profile.getLName = obj.saver_lName
            profile.getCity = ""
            profile.getRole = obj.saverDegree
            
            profile.getImage = obj.saver_image
            profile.followedByMe = 0
            profile.bio = ""
            profile.profileId = obj.saver_id
            profile.getOwner = owner
            self.present(profile, animated: true, completion: nil)
        
    }
    @IBOutlet weak var uiTabelSavers: UITableView!
    
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
