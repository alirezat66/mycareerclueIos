//
//  AddCollectionStepFour.swift
//  WeYouMaster
//
//  Created by alireza on 11/14/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class SelectContriButeType: UIViewController , UITableViewDelegate,UITableViewDataSource{
     var getCollectionId = String()
    var  getCollectionName = String()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell" ) as? FeedTypeCell else {return UITableViewCell()}
        cell.updateView(message: tableViewData[indexPath.item])
        return cell
    }
    
    @IBOutlet weak var tableView : UITableView!
    var tableViewData : [String] = ["تجربه کاری","آپدیت","رویدادهای آموزشی","نقل قول بزرگان","درس آموزشی","موقعیت شغلی"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        weak var pvc = self.presentingViewController
        
        self.dismiss(animated: true, completion: {
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.tableViewData[indexPath.item], forKey: "selectedType")
            let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
            let add = stroyBoard.instantiateViewController(withIdentifier: "addcontribution" ) as? AddContribution
            if(self.getCollectionId != ""){
                add?.collectionId = self.getCollectionId
                add?.collName = self.getCollectionName
            }
            
            pvc?.present(add!, animated: true, completion: nil)
        })
       
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
