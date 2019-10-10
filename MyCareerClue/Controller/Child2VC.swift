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
    var firstTime  = true
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
        if(myCollections.count == 0 ){
            if(!firstTime){
            let image = UIImage(named: "AppIcon.png");

            tableView.setEmptyView(title: "No information yet", message: "Chapters will be in here.",messageImage: image!)
            }
        }else{
            tableView.restore()
        }
        return myCollections.count
    }
     var myCollections : [CollectionChapter] = []
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "Chapters")
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "chaptercell") as? ChapterCell{
            let collection = myCollections[indexPath.row]
            cell.updateView(chapter: collection, isOwner: self.isOwner)
            cell.onButtonDelete = {
            }
            cell.onButtonEdit = {
                
            }
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
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        getCloolections()
    }
    func getCloolections(){
        let userDefaults = UserDefaults.standard
       
        
        let owner = userDefaults.value(forKey: "owner") as! String
        print(owner)
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
            self.firstTime = false
            self.collectionTV.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            self.firstTime = false
            SVProgressHUD.dismiss()
            self.collectionTV.reloadData()
            self.refreshControll?.endRefreshing()
            
            
        }
    }

  

}

extension UITableView {
    
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(messageLabel)
        
        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -20).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
            
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { (finish) in
            UIView.animate(withDuration: 1, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { (finishh) in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
            
        })
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
}
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
