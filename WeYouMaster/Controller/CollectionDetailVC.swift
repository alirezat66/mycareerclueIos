//
//  CollectionDetailVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/21/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
class CollectionDetailVC:
UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var myContent : [Content] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myContent.count //DataService.instance.getContent().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? OtherFeed {
            cell.updateView(content: myContent[indexPath.row])
            return cell
        }else{
            return OtherFeed()
        }
       
    }
    

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    var getName = String()
    var getCity = String()
    var getTitle = String()
    var getImage = String()
    var collectionId = String()
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
    }
    @IBOutlet weak var contentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = getName
        lblCity.text = getCity
        lblTitle.text = getTitle
        
        
        
        
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        contentTable.dataSource = self
        contentTable.delegate = self
        
        
        if(getImage != "")
        {
            let url = URL(string : getImage)
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.imgPerson.image = image
                        }
                    }
                }
            }
        }
        
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        getFeeds()
        // Do any additional setup after loading the view.
    }

    func getFeeds(){
       
       
        WebCaller.getFeedsOfCollection(collectionId
        ) { (contents, error) in
            if let error = error{
                print(error)
                return
            }
            guard let contentList = contents else{
                print("error getting collections")
                return
            }
            for content in (contentList.records.posts) {
                self.myContent.append(content)
            }
            self.updateUI()
        
        }
    }
    
    func updateUI(){
        DispatchQueue.main.async{
            self.contentTable.reloadData()
                SVProgressHUD.dismiss()
            
            
        }
    }
    
}
