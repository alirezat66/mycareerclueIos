//
//  CollectionVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//
 
import UIKit

class CollectionVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DataService.instance.getCollections().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as? CollectionCell{
            let collection = DataService.instance.getCollections()[indexPath.row]
            cell.updateView(collection:collection)
            return cell
        }else{
            return  CollectionCell()
        }
    }
    
    @IBOutlet weak var collectionTV :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionTV.dataSource = self
        collectionTV.delegate = self

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let StoryBoard  = UIStoryboard(name: "Main", bundle: nil)
        let DVC  = StoryBoard.instantiateViewController(withIdentifier:"CollectionDetailVC" ) as? CollectionDetailVC
        let collection = DataService.instance.getCollections()[indexPath.row]
        let name = collection.fName + " " + collection.lName
        DVC?.getName = name
        DVC?.getCity = collection.place
        DVC?.getTitle = collection.title
        DVC?.getImage = UIImage(named: collection.img)!
        self.navigationController?.pushViewController(DVC!, animated: true)
        
        
    }

  
}
