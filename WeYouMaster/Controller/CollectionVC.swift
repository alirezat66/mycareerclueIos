//
//  CollectionVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/18/18.
//  Copyright © 2018 alireza. All rights reserved.
//
 
import UIKit

class CollectionVC: UIViewController,UITableViewDelegate , UITableViewDataSource {
    let spinnerIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
     let alertController = UIAlertController(title: nil, message: "لطفا منتظر بمانید ...\n\n", preferredStyle: .alert)
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
        
       
        
      
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertController.view.addSubview(spinnerIndicator)
        self.present(alertController, animated: false, completion: nil)
        
        
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
        self.alertController.dismiss(animated: true, completion: nil);

        }
    }
   
}
