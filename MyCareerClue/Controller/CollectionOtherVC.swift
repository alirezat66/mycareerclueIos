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
    var isOwner = Bool()
    var firstTime = true
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "COLS")
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
        if(myCollections.count == 0){
            if(!firstTime){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Collections will be in here.",messageImage: image!)
            }
        }
        return myCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as? CollectionCellOtherTVC{
            let collection = myCollections[indexPath.row]
            cell.updateView(collection:collection , isOwner: self.isOwner)
            cell.onPricingTap = {
                let userDefaults = UserDefaults.standard
                let planStatus = userDefaults.value(forKey: "planStatus") as! Int
                
                if(planStatus >= 2){
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertPriceVC") as! AlartPriceVC
                    vc.getTitle = collection.Collection_Title
                    vc.collectionId = collection.collectionId
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                    self.addChildViewController(vc)
                    self.view.addSubview(vc.view)
                    
                }else {
                    let alert = UIAlertController(title: "Info", message: "You cant change price", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Undrstand", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
            cell.onTitleTappedOnShow = {
                 let name = collection.owner_name + " " + collection.owner_lName
                self.openDetail(degree: collection.ownerDegree, name: name, title: collection.Collection_Title, image: collection.collection_owner_image,collectionId: collection.collectionId,numOfPost: collection.collection_posts_number,startDate: collection.Published_Date)
            }
            cell.onButtonTappedOnShow = {
                
                if(!self.isOwner){
                let name = collection.owner_name + " " + collection.owner_lName
               self.openDetail(degree: collection.ownerDegree, name: name, title: collection.Collection_Title, image: collection.collection_owner_image,collectionId: collection.collectionId,numOfPost: collection.collection_posts_number,startDate: collection.Published_Date)
                }else {
                    self.openCollectionType(collectionId: collection.collectionId,collectionName: collection.Collection_Title)
                }
            }
            
            cell.onButtonDelete = {
                self.deleteItem(collectionId: collection.collectionId,index: indexPath.row)
            }
            cell.onButtonEdit =  {
                 self.editCollection(collection.Collection_Description,collection.Collection_Title,collection.collection_price,collection.collectionId)
                
            }
            return cell
        }else{
            return  CollectionCell()
        }
    }
    
    func openProfile(collection:Collection) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
        profile.getFName = collection.owner_name
        profile.getLName = collection.owner_lName
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
    override func viewDidAppear(_ animated: Bool) {
        myCollections = []
        collectionTV.dataSource = self
        collectionTV.delegate = self
        SVProgressHUD.show(withStatus: "Please Wait... \n\n")
        getCloolections()
    }
    func deleteItem(collectionId : String , index : Int){
        
        let refreshAlert = UIAlertController(title: "delete", message: "Are You Sure?", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            SVProgressHUD.show(withStatus: "Please Wait  ... \n\n")
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
           
            WebCaller.deleteCollection(owner,collectionId) { (errorMessage , error) in
                if let error = error{
                    self.updateError()
                    print(error)
                    return
                }
                guard let errorMessage = errorMessage else{
                    self.updateError()
                    print("error getting collections")
                    return
                }
                
                
                if(errorMessage.error==0){
                    self.myCollections.remove(at: index)
                    self.updateUI()
                }
                
                
                
            }
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    func getCloolections(){
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.value(forKey: "otherUser") as! String
        let owner = userDefaults.value(forKey: "owner") as! String
        
        WebCaller.getCollectionOther(20,1,owner: owner,userId: userId) { (collections , error) in
            if let error = error{
                self.updateListError()
                print(error)
                return
            }
            guard let collections = collections else{
                self.updateListError()
                print("error getting collections")
                return
            }
            
            
            for collect in collections.records{
                self.myCollections.append(collect)
            }
            self.updateUI()
            
            
        }
    }
    
    
    func updateUI(){
        DispatchQueue.main.async{
            self.firstTime = false
            self.collectionTV.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()

            
        }
    }
    func updateListError(){
        DispatchQueue.main.async{
            self.collectionTV.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
            
            
        }
    }
    public func editCollection(_ Collection_Description : String , _ Collection_Title : String , _ collection_price  : String , _  collectionId : String ){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let add = storyBoard.instantiateViewController(withIdentifier: "addCollection") as! AddCollectionVC
        
        add.editCollectionId = collectionId
        add.editCollectionTitle = Collection_Title
        add.editCollectionDesc = Collection_Description
        add.editPrice = collection_price
        self.present(add, animated: true, completion: nil)
        
    }
    
    public func openCollectionType(collectionId : String, collectionName : String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let contributionType = storyBoard.instantiateViewController(withIdentifier: "selectContributeType") as! SelectContriButeType
        contributionType.getCollectionId = collectionId
        
        self.present(contributionType, animated: true, completion: nil)
    }
    public func openDetail(degree : String , name : String ,title : String , image : String ,collectionId : String , numOfPost : Int,startDate : String){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyBoard.instantiateViewController(withIdentifier: "collectionDetail") as! CollectionDetailTwoVC
        detail.getDegree = degree
        detail.getName = name
        detail.getTitle = title
        detail.getImage = image
        detail.collectionId = collectionId
        detail.numberOdPost = numOfPost
        detail.getStartDate = startDate
        self.present(detail, animated: true, completion: nil)
        
    }
    
}
