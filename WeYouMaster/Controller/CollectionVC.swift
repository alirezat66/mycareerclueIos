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
   
    var myCollections : [Collection] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as? CollectionCell{
            let collection = myCollections[indexPath.row]
            cell.updateView(collection:collection)
            cell.onButtonTapped = {
                self.openProfile(collection : collection)
            }
            return cell
        }else{
            return  CollectionCell()
        }
    }
    
    func openProfile(collection:Collection) {
        
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
            profile.getName = collection.owner_name + collection.owner_lName
            profile.getCity = collection.collection_place
            profile.getRole = collection.ownerDegree
            profile.getImage = collection.collection_owner_image
            self.present(profile, animated: true, completion: nil)
    }
    @IBOutlet weak var collectionTV :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTV.dataSource = self
        collectionTV.delegate = self
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getCloolections()
    }
   
    func getCloolections(){
        WebCaller.getCollection(20,1,owner: "24",userId: "-1") { (collections , error) in
            if let error = error{
                print(error)
                return
            }
            guard let collections = collections else{
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
        openDetail(city: selectedRow.collection_place, name: name, title: selectedRow.Collection_Title, image: selectedRow.collection_owner_image,collectionId: selectedRow.collectionId)
    }
    
    func updateUI(){
        DispatchQueue.main.async{
        self.collectionTV.reloadData()
        SVProgressHUD.dismiss()
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
