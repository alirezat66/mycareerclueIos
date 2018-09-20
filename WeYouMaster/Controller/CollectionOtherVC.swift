//
//  CollectionOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip

class CollectionOtherVC: UIViewController,UITableViewDelegate , UITableViewDataSource ,IndicatorInfoProvider {
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "مجموعه ها")
    }
    var refreshControll : UIRefreshControl?
    
    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        collectionTV.addSubview(refreshControll!)
    }
    @objc func refreshList(){
        myCollections = []
        getCloolections()
    }
    var myCollections : [CollectionOther] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as? CollectionCellOtherTVC{
            let collection = myCollections[indexPath.row]
            cell.updateView(collection:collection)
           
            return cell
        }else{
            return  CollectionCell()
        }
    }
    
    func openProfile(collection:Collection) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
       /* profile.getName = collection.owner_name + collection.owner_lName
        profile.getCity = collection.collection_place
        profile.getRole = collection.ownerDegree
        profile.getImage = collection.collection_owner_image
        profile.followedByMe = collection.followByMe*/
        self.present(profile, animated: true, completion: nil)
    }
    @IBOutlet weak var collectionTV :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addRefreshControl()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        myCollections = []
        collectionTV.dataSource = self
        collectionTV.delegate = self
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getCloolections()
    }
    
    func getCloolections(){
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "otherUser") as! String
        WebCaller.getCollectionOther(20,1,owner: "24",userId: owner) { (collections , error) in
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
            
            
            for collect in collections.collections{
                self.myCollections.append(collect)
            }
            self.updateUI()
            
            
        }
    }
    
    
    func updateUI(){
        DispatchQueue.main.async{
            self.collectionTV.reloadData()
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
    public func openDetail(city : String , name : String ,title : String , image : String ,collectionId : String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "CollectionDetailVC") as! CollectionDetailVC
        detail.getCity = city
        detail.getName = name
        detail.getTitle = title
        detail.getImage = image
        detail.collectionId = collectionId
        
        self.present(detail, animated: true, completion: nil)
        
    }
    
}
