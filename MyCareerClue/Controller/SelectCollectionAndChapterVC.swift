//
//  SelectCollectionAndChapterVC.swift
//  WeYouMaster
//
//  Created by alireza on 12/6/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
struct cellData {
    var opend = Bool()
    var title = String()
    var sectionData = [String]()
}
class SelectCollectionAndChapterVC: UIViewController , UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var tableView : UITableView?
    var tableViewData = [ExpendedCollection]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableViewData[section].open){
           return tableViewData[section].collection.chapters.count + 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ) as? CollectionExpendedCell else {return UITableViewCell()}
            cell.updateView(message: tableViewData[indexPath.section])
          //  cell.lblText?.text = tableViewData[indexPath.section].collection.collectionName
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ) as? CollectionExpendedCell else {return UITableViewCell()}
            cell.updateView(message: tableViewData[indexPath.section].collection.chapters[indexPath.row-1])
           
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return tableViewData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableViewData[indexPath.section].open == true {
            tableViewData[indexPath.section].open = false
            let section = IndexSet.init(integer : indexPath.section)
            tableView.reloadSections(section, with: .none)
             print(" opened father")
               var stringName = ""
            
            if(tableViewData[indexPath.section].collection.chapters.count>indexPath.row-1 && indexPath.row != 0){
                    stringName = tableViewData[indexPath.section].collection.chapters[indexPath.row-1].chapterName
            }else{
                stringName = tableViewData[indexPath.section].collection.collectionName
            }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(tableViewData[indexPath.section].collection.collection, forKey: "selectedCollection")
            userDefaults.set(stringName, forKey: "selectedCollectionName")
            self.dismiss(animated: true, completion: nil)
            
            
        }else{
        if(tableViewData[indexPath.section].collection.chapters.count>0){
            print("not child")
            }else{
            
            var stringName = ""; if(tableViewData[indexPath.section].collection.chapters.count>indexPath.row-1 && indexPath.row != 0){
                stringName = tableViewData[indexPath.section].collection.chapters[indexPath.row-1].chapterName
            }else{
                stringName = tableViewData[indexPath.section].collection.collectionName
            }
            
            let userDefaults = UserDefaults.standard
            userDefaults.set(tableViewData[indexPath.section].collection.collection, forKey: "selectedCollection")
            userDefaults.set(stringName, forKey: "selectedCollectionName")
            self.dismiss(animated: true, completion: nil)
            }
            tableViewData[indexPath.section].open = true
            let section = IndexSet.init(integer : indexPath.section)
            tableView.reloadSections(section, with: .none)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        getChapters()
        // Do any additional setup after loading the view.
    }
    
    func getChapters(){
        loadingView.isHidden  = false
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getChapters(owner: owner) { (collections , error) in
            if let error = error{
                print(error)
                return
            }
            guard let collections = collections else{
                print("error getting collections")
                return
            }
            if(self.tableViewData.count>0){
                self.tableViewData.remove(at: 0)
                
            }
            for collect in collections.records{
                self.tableViewData.append(ExpendedCollection(collection: collect,open: false))
            }
            self.updateUIForCollection()
        }
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func updateUIForCollection(){
        // first we add dropper
        
        
        DispatchQueue.main.async{
            self.tableView?.reloadData()
            self.loadingView.isHidden  = true
        }
        
        // second we add search list
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
