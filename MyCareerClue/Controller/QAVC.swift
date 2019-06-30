//
//  QAVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/28/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class QAVC: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? QACell{
            let qa = qaList[indexPath.row]
            cell.updateView(qa: qa)
            return cell
        }else{
            return  CollectionCell()
        }
    }
    
   
     let qaList = WebCaller.makeQaList() 
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var qaTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        qaTable.delegate = self
        qaTable.dataSource = self
       
        
    }

    
    

    

}
