//
//  SearchVC.swift
//  WeYouMaster
//
//  Created by alireza on 1/19/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchVC: UIViewController ,UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var UITable: UITableView!
    var myResult : [SearchObj] = []
    @IBOutlet weak var edtSearch: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myResult.count
    }
    @IBAction func btnBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func edtChange(_ sender: Any) {
        let str = edtSearch.text!
        
        if(str.count>=2){
            SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
            getSearch(str: str)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(myResult.count>=indexPath.row){
             let search = myResult[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "mySearchCell") as? SearchCell{
                
               cell.updateView(search: search)
                return cell
            }else{
                return SearchCell()
            }
        }
       else{
            return  SearchCell()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UITable.dataSource = self
        UITable.delegate = self
        
        

      
    }
    func getSearch(str:String) {
        myResult.removeAll()
        WebCaller.search(str) {
            (searchList, error) in
            if let error = error{
                print(error)
                self.updateError()
                return
                }
            guard let searchList = searchList else {
                self.updateError()
                print("error getting search list")
                return
            }
            for search in searchList.records{
                self.myResult.append(search)
            }
            self.updateUI()
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(){
        DispatchQueue.main.async{
            self.UITable.reloadData()
            
            //  self.goToLast()
            
            SVProgressHUD.dismiss()
            
        }
    }
    

    
}