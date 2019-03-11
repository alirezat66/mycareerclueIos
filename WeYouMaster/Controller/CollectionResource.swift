//
//  CollectionResource.swift
//  WeYouMaster
//
//  Created by alireza on 3/10/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip
class CollectionResource: UIViewController ,UITableViewDelegate , UITableViewDataSource,IndicatorInfoProvider   {
    var myResources : [Resource] = []
    var isOwner = Bool()
    var getCollection = String()

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "منابع")
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
            self.table.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
            
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        myResources = []
        table.dataSource = self
        table.delegate = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getResources()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        let userId = userDefaults.value(forKey: "owner") as! String
        WebCaller.getMyResourcesCollection(userId , getCollection) { (resources , error) in
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
