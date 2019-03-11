//
//  Child2VC.swift
//  WeYouMaster
//
//  Created by alireza on 9/20/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class Child2VC: UIViewController,UITableViewDelegate , UITableViewDataSource, IndicatorInfoProvider {
    var isOwner = Bool()
    var collectionId = String()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myCollections.count
    }
     var myCollections : [CollectionChapter] = []
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "فصل ها")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chaptercell") as? ChapterCell{
            let collection = myCollections[indexPath.row]
            cell.updateView(chapter: collection, isOwner: self.isOwner)
            
            
          /*  cell.onButtonDelete = {
                self.deleteItem(collectionId: collection.collectionId,index: indexPath.row)
            }
            cell.onButtonEdit =  {
                self.editCollection(collection.Collection_Description,collection.Collection_Title,collection.collection_price,collection.collectionId)
                
            }*/
            return cell
        }else{
            return  ChapterCell()
        }
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
        
        // Do any additional setup after loading the view.
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
       
        
        let owner = userDefaults.value(forKey: "owner") as! String
         let userId = userDefaults.value(forKey: "otherUser") as! String
        WebCaller.getChapters(50, 1,"on",userId,collectionId
        ) { (contents, error) in
            if let error = error{
                self.updateError()
                print(error)
                return
            }
            guard let contentList = contents else{
                self.updateError()
                print("error getting collections")
                return
            }
            for content in (contentList.records) {
                self.myCollections.append(content)
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

  

}
