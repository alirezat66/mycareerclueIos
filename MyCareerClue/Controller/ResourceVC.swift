//
//  ResourceVC.swift
//  WeYouMaster
//
//  Created by alireza on 3/10/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip
class ResourceVC: UIViewController,UITableViewDelegate , UITableViewDataSource,IndicatorInfoProvider   {
    var myResources : [Resource] = []
    var firstTime  = true
    var isOwner = Bool()
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "RES")
    }
    @objc func refreshList(){
        myResources = []
        getResources()
    }
    var refreshControll : UIRefreshControl?
    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        table.addSubview(refreshControll!)
    }
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.value(forKey: "otherUser") as! String
        let owner = userDefaults.value(forKey: "owner") as! String
        
        if(userId == owner){
            isOwner = true
        }else {
            isOwner = false
        }
        addRefreshControl()
       
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.firstTime = false
            self.table.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            self.firstTime = false
            self.table.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
            
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        myResources = []
        table.dataSource = self
        table.delegate = self
        SVProgressHUD.show(withStatus: " Please Wait ... \n\n")
        getResources()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(myResources.count == 0){
            if(!firstTime){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Resources will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myResources.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell") as? ResourceCell{
            let resource = myResources[indexPath.row]
            cell.updateView(source: resource, isOwner: self.isOwner)
           
            return cell
        }else{
            return  CollectionCell()
        }
    }
    func getResources(){
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.value(forKey: "otherUser") as! String
        WebCaller.getMyResources(userId , 1,40) { (resources , error) in
            if let error = error{
                self.updateError()
                print(error)
                return
            }
            guard let myresult = resources else{
                self.updateError()
                print("error getting collections")
                return
            }
            
            
            for resource in myresult.records{
            self.myResources.append(resource)
            }
            self.updateUI()
            
            
        }
    }

}
