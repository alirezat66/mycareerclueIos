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
        
       
        
      
      
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getCloolections()
    }
   
    func getCloolections(){
        WebCaller.getCollection { (collections , error) in
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
    
    func updateUI(){
        DispatchQueue.main.async{
        self.collectionTV.reloadData()
        SVProgressHUD.dismiss()
        }
    }
   
}
