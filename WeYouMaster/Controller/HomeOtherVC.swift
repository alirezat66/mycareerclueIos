//
//  HomeOtherVC.swift
//  WeYouMaster
//
//  Created by alireza on 9/4/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import SVProgressHUD
import XLPagerTabStrip
import ExpandableLabel

class HomeOtherVC: UIViewController,UITableViewDelegate,UITableViewDataSource , IndicatorInfoProvider , ExpandableLabelDelegate{
    var states : Array<Bool>!
    func willExpandLabel(_ label: ExpandableLabel) {
        label.textAlignment = NSTextAlignment.right
        homeTable.beginUpdates()
        label.textAlignment = NSTextAlignment.right
        
    }
    
    func didExpandLabel(_ label: ExpandableLabel) {
        let point = label.convert(CGPoint.zero, to: homeTable)
        if let indexPath = homeTable.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = false
            
            DispatchQueue.main.async { [weak self] in
                self?.homeTable.scrollToRow(at: indexPath, at: .top, animated: true)
            }
        }
        label.textAlignment = NSTextAlignment.right
        homeTable.endUpdates()
        label.textAlignment = NSTextAlignment.right
        
    }
    
    func willCollapseLabel(_ label: ExpandableLabel) {
        label.textAlignment = NSTextAlignment.right
        
        homeTable.beginUpdates()
        label.textAlignment = NSTextAlignment.right
        
    }
    
    func didCollapseLabel(_ label: ExpandableLabel) {
        
        let point = label.convert(CGPoint.zero, to: homeTable)
        if let indexPath = homeTable.indexPathForRow(at: point) as IndexPath? {
            states[indexPath.row] = true
            DispatchQueue.main.async { [weak self] in
                self?.homeTable.scrollToRow(at: indexPath, at: .top, animated: true)
                
            }
        }
        label.textAlignment = NSTextAlignment.right
        homeTable.endUpdates()
        label.textAlignment = NSTextAlignment.right
        
    }
    
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "تایم لاین")
    }
    
    var myContent : [OtherContent] = []
    var isOpenMenu = false
    
    var refreshControll : UIRefreshControl?

    func addRefreshControl() {
        refreshControll = UIRefreshControl()
        refreshControll?.tintColor = UIColor.purple
        refreshControll?.addTarget(self, action: #selector(refreshList), for: .valueChanged)
        homeTable.addSubview(refreshControll!)
    }
    @objc func refreshList(){
        myContent = []
        getFeeds()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(myContent.count >= indexPath.row){
        let content = myContent[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell") as? HomeOtherCell {
            cell.updateView(content: content)
            
            cell.lblContent.delegate = self
            
            cell.lblContent.collapsedAttributedLink = NSAttributedString(string: "بیشتر")
            cell.lblContent.setLessLinkWith(lessLink: "کمتر", attributes: [.foregroundColor:UIColor.red], position: NSTextAlignment.left)
            cell.layoutIfNeeded()
            cell.lblContent.shouldCollapse = true
            cell.lblContent.textReplacementType = .word
            cell.lblContent.numberOfLines =  4
            cell.lblContent.collapsed = true
            cell.lblContent.text = content.contentText
            cell.lblContent.textAlignment = NSTextAlignment.right
            return cell
        }else{
            return HomeCell()
        }
        }else{
            return HomeCell()
        }
    }
    func openProfile(content:Content) {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let profile = storyBoard.instantiateViewController(withIdentifier: "profileOther") as! ProfileOtherVC
      /*  profile.getName = content.fName! + content.lName!
        profile.getCity = content.location!
        profile.getRole = content.education!
        profile.getImage = content.ownerPic!
        profile.followedByMe = content.followByMe!*/
        self.present(profile, animated: true, completion: nil)
    }
    func makeButtonCirc(obj : UIButton) {
        obj.layer.cornerRadius = obj.layer.frame.width/2
        obj.clipsToBounds = true
    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var homeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTable.rowHeight = UITableViewAutomaticDimension
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        addRefreshControl()
        getFeeds()
    }
    override func viewDidAppear(_ animated: Bool) {
        
     
        homeTable.dataSource = self
        homeTable.delegate = self
      
        // Do any additional setup after loading the view.
        
        
    }
    func getFeeds(){
        let userDefaults = UserDefaults.standard
        
        let userId = userDefaults.value(forKey: "otherUser") as! String
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getUserFeed(50, 1,userId,owner
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
            for content in (contentList.contributions) {
                self.myContent.append(content)
            }
             self.states = [Bool](repeating: true, count: contentList.contributions.count)
            self.updateUI()
        }
    }
    
    func updateUI(){
        DispatchQueue.main.async{
            self.homeTable.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()

            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateError(){
        DispatchQueue.main.async{
            self.homeTable.reloadData()
            SVProgressHUD.dismiss()
            self.refreshControll?.endRefreshing()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
}
