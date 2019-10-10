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
    var isFirst = true
    var myResult : [SaverResp] = []
    var myResult2 : [CollectionFollower] = []
    @IBOutlet weak var lblTitle: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(isCollection){
            if(myResult2.count == 0 ){
                if(!isFirst){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Saved Contributions will be in here.",messageImage: image!)
                }
            }else{
                tableView.reloadData()
            }
            return myResult2.count
            
        }else{
            if(myResult.count == 0 ){
                if(!isFirst){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Saved Contributions will be in here.",messageImage: image!)
                }
            }else{
                tableView.restore()
            }
        return myResult.count
        }
    }
    var getContributionId = String()
    var getOwner  = String()
    var getTitle = String()
    var getCollectionId  = String()
    var isCollection = false
    override func viewDidLoad() {
        super.viewDidLoad()
        uiTabelSavers.dataSource = self
        uiTabelSavers.delegate = self
        
        if(getTitle == "") {
            isCollection = false
        getList();
        }else{
            isCollection = true
            lblTitle.text = "Followers" + getTitle
            getList(collectionId: getCollectionId)
        }
        // Do any additional setup after loading the view.
    }
    func getList(){
         myResult.removeAll()
           SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
       
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
    func getList(collectionId : String){
        myResult.removeAll()
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        
        WebCaller.collectionFollowers(getCollectionId) {
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
                self.myResult2.append(search)
            }
            self.updateUI()
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            self.isFirst = false
            self.uiTabelSavers.reloadData()
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.isFirst = false
            self.uiTabelSavers.reloadData()
            
            //  self.goToLast()
            
            SVProgressHUD.dismiss()
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(isCollection){
            if(myResult.count>=indexPath.row){
                let search = myResult2[indexPath.row]
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
        }else {
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
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isCollection){
            let obj = myResult2[indexPath.row]
            
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            
            profile.getFName = obj.follower_name
            profile.getLName = obj.follower_lName
            profile.getCity = ""
            profile.getRole = obj.followerDegree
            
            profile.getImage = obj.follower_image
            profile.followedByMe = 0
            profile.bio = ""
            profile.profileId = obj.follower_id
            profile.getOwner = owner
            self.present(profile, animated: true, completion: nil)
        }else {
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
