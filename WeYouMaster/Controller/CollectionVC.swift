//
//  CollectionVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//
 
import UIKit
import SVProgressHUD
class CollectionVC: UIViewController,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var imgNot1: UIButton!
    @IBOutlet weak var imgNot2: UIButton!
    @IBOutlet weak var imgNot3: UIButton!
    @IBOutlet weak var imgNot4: UIButton!
    @IBOutlet weak var imgNot5: UIButton!
    @IBOutlet weak var imgNot6: UIButton!
    @IBOutlet weak var imgNot7: UIButton!
    @IBOutlet weak var imgNot8: UIButton!
    @IBOutlet weak var imgNot9: UIButton!
    
    @IBOutlet weak var imgProfile: UIButton!
    
    var refreshControll : UIRefreshControl?
    var myCollections : [Collection] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myCollections.count
    }
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as? CollectionCell{
            let collection = myCollections[indexPath.row]
            cell.updateView(collection:collection)
            cell.onButtonTapped = {
                self.openProfile(collection : collection)
            }
            cell.onButtonTappedOnShow = {
                let name = collection.owner_name + " " + collection.owner_lName
                self.openDetail(degree: collection.ownerDegree, name: name, title: collection.Collection_Title, image: collection.collection_owner_image,collectionId: collection.collectionId,numOfPost: collection.collection_posts_number,startDate: collection.Published_Date)
            }
            return cell
        }else{
            return  CollectionCell()
        }
    }
    
    func openProfile(collection:Collection) {
        
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "tablayout") as! ProfileTabVC
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        profile.getName = collection.owner_name + " " + collection.owner_lName
        profile.getCity = collection.collection_place
        profile.getRole = collection.ownerDegree
        profile.getImage = collection.collection_owner_image
        profile.followedByMe = collection.followByMe
        profile.profileId = collection.Owner
        profile.getOwner = owner
        profile.bio = ""
        self.present(profile, animated: true, completion: nil)
        
    }
    @IBOutlet weak var collectionTV :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.width/2
        imgProfile.clipsToBounds = true
        makeButtonCirc(obj: imgNot1)
        makeButtonCirc(obj: imgNot2)
        makeButtonCirc(obj: imgNot3)
        makeButtonCirc(obj: imgNot4)
        makeButtonCirc(obj: imgNot5)
        makeButtonCirc(obj: imgNot6)
        makeButtonCirc(obj: imgNot7)
        makeButtonCirc(obj: imgNot8)
        makeButtonCirc(obj: imgNot9)
        let userDefaults = UserDefaults.standard

        let Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        if(Profile_photo_link != ""){
            
            let url = URL(string: Profile_photo_link)
            
            
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            
                            
                            self?.imgProfile.setImage(image, for: UIControlState.normal)
                            
                        }
                    }
                }
            }
        }else{
            DispatchQueue.main.async {
                self.imgProfile.setImage(UIImage(named: "avatar_icon.png"), for: UIControlState.normal)
            }
        }
    }
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
        
        myCollections = []
        
        updateUI()
        
        collectionTV.dataSource = self
        collectionTV.delegate = self
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getCloolections()
        addRefreshControl()
    }
   
    func getCloolections(){
        WebCaller.getCollection(20,1,owner: "24",userId: "-1",state: "on") { (collections , error) in
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = myCollections[indexPath.row]
        let name = selectedRow.owner_name + " " + selectedRow.owner_lName
        openDetail(degree: selectedRow.ownerDegree, name: name, title: selectedRow.Collection_Title, image: selectedRow.collection_owner_image,collectionId: selectedRow.collectionId,numOfPost: selectedRow.collection_posts_number,startDate: selectedRow.Published_Date)
    }
    func updateError(){
        DispatchQueue.main.async{
            self.refreshControll?.endRefreshing()
            SVProgressHUD.dismiss()
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
        self.collectionTV.reloadData()
        SVProgressHUD.dismiss()
        self.refreshControll?.endRefreshing()
        }
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
