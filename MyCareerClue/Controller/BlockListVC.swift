//
//  BlockListVC.swift
//  MyCareerClue
//
//  Created by AliReza Taghizadeh on 9/7/19.
//  Copyright © 2019 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
class BlockListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var myContent : [BlockObject] = []
    var isFirst  =  true
    override func viewDidLoad() {
         myContent = []
        blocktableView.dataSource = self
        blocktableView.delegate = self
        blocktableView.rowHeight = UITableViewAutomaticDimension
        SVProgressHUD.show(withStatus: "Please Wait... \n\n")
        getBlockList();
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func getBlockList() {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.blockList(owner
        ) {
            
            (contents, error) in
            if let error = error{
                self.updateListError()
                print(error)
                return
            }
            guard let contentList = contents else{
                self.updateListError()
                print("error getting collections")
                return
            }
            for content in (contentList.records) {
                self.myContent.append(content)
            }
            
            
            self.updateUI()
        }
    }
    func updateListError(){
        DispatchQueue.main.async{
            self.isFirst = false
            self.blocktableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
        }
    }
    func updateUI(){
    DispatchQueue.main.async{
    self.isFirst  = false
    self.blocktableView.reloadData()
    SVProgressHUD.dismiss()
    //self.alertController.dismiss(animated: true, completion: nil);
    }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(myContent.count == 0 ){
            if(!isFirst){
                let image = UIImage(named: "AppIcon.png");
                
                tableView.setEmptyView(title: "No information yet", message: "Blocked users will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myContent.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
            let content = myContent[indexPath.row]
            if let cell = tableView.dequeueReusableCell(withIdentifier: "blockCell") as? BlockUserCell {
                cell.updateView(content: myContent[indexPath.row])
                
              
                cell.onButtonTapped = {
                    self.unblock(content : content)
                }
                 return cell;
            }else{
                return BlockUserCell()
            }
           
        }else {
            return BlockUserCell()
        }
    }
    func unblock(content : BlockObject)  {
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        SVProgressHUD.show(withStatus: "Please Wait... \n\n")

        WebCaller.unblock(content.reportedId,owner
        ) {
            
            (contents, error) in
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
            
            self.removeFromList(content: contentList)
            let userDefaults = UserDefaults.standard
            userDefaults.set(true, forKey: "isBlock")
            
        }
    }
    func removeFromList(content : UnBlockObject) {
        DispatchQueue.main.async{
            for cont in self.myContent {
                if(cont.reportedId == content.profileId
                    ){
                    self.deleteItem(content: cont)
                    break
                }
                
            }
            SVProgressHUD.dismiss()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
            //self.alertController.dismiss(animated: true, completion: nil);
            
        
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func deleteItem(content : BlockObject)  {
        DispatchQueue.main.async{
            let index =  self.myContent.firstIndex(of: content)
            if(index != nil){
                self.blocktableView.beginUpdates()
                self.blocktableView.deleteRows(at: [ IndexPath(row: index!, section: 0) ], with: .fade)
                self.myContent.remove(at: index!)
                self.blocktableView.endUpdates()
            }
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    @IBOutlet weak var blocktableView: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
