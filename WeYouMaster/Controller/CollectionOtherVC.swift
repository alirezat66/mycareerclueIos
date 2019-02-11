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
            cell.updateView(collection:collection , isOwner: self.isOwner)
            cell.onButtonTappedOnShow = {
                let name = collection.owner_name + " " + collection.owner_lName
               self.openDetail(degree: collection.ownerDegree, name: name, title: collection.Collection_Title, image: collection.collection_owner_image,collectionId: collection.collectionId,numOfPost: collection.collection_posts_number,startDate: collection.Published_Date)
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
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getCloolections()
    }
    func deleteItem(collectionId : String , index : Int){
        
        let refreshAlert = UIAlertController(title: "حذف", message: "آیا واقعا تمایل به حذف دارید؟", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "بله", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
            SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
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
        
        refreshAlert.addAction(UIAlertAction(title: "خیر", style: .cancel, handler: { (action: UIAlertAction!) in
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
                self.updateError()
                print(error)
                return
            }
            guard let collections = collections else{
                self.updateError()
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
    public func editCollection(_ Collection_Description : String , _ Collection_Title : String , _ collection_price  : String , _  collectionId : String ){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let add = storyBoard.instantiateViewController(withIdentifier: "addCollection") as! AddCollectionVC
        
        add.editCollectionId = collectionId
        add.editCollectionTitle = Collection_Title
        add.editCollectionDesc = Collection_Description
        add.editPrice = collection_price
        self.present(add, animated: true, completion: nil)
        
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
