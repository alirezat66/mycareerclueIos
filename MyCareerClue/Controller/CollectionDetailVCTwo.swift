//
//  CollectionDetailVCTwo.swift
//  WeYouMaster
//
//  Created by alireza on 9/25/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import SVProgressHUD

class CollectionDetailVCTwo: UIViewController , IndicatorInfoProvider{
    
    
    @IBOutlet weak var lblInclude: UILabel!
    
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var holeView: UIScrollView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDegree: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPerson: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    var getName = String()
    var getDegree = String()
    var getTitle = String()
    var getImage = String()
    var collectionId = String()
    var getStartDate = String()
    var numberOdPost = Int()
    var folowByMe = Int()
    var myColInfo : ColInfo? = nil
    var isFree  = Bool()
    @IBOutlet weak var detailView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getCollectionInfo()
    }
    @IBAction func btnSecondAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.value(forKey: "otherUser") as! String
        let owner = userDefaults.value(forKey: "owner") as! String
        
        if(userId == owner){
            // make feed
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let add = storyBoard.instantiateViewController(withIdentifier: "selectContributeType") as! SelectContriButeType
            let userDefaults = UserDefaults.standard
            userDefaults.set("0", forKey: "selectedCollection")
            self.present(add, animated: true, completion: nil)
        }else{
            callDisLike(follow: folowByMe)
        }
    }
    
    
    func callDisLike(follow : Int) {
        
        let userDefaults = UserDefaults.standard
        
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.followDisFollowCollection(follow, owner,collectionId) { (state, error) in
            if let error = error{
                print(error)
                return
            }
            guard let state = state else{
                print("error getting collections")
                return
            }
            if(state == 1 ){
                print("like done")
                if(follow == 1){
                    self.folowByMe = 0
                    DispatchQueue.main.async{
                        SVProgressHUD.dismiss()
                        
                        self.btnSecond.setTitle("+Follow Collection", for: .normal)
                    }
                }else{
                    DispatchQueue.main.async{
                        SVProgressHUD.dismiss()
                        
                        self.folowByMe = 0
                        self.btnSecond.setTitle("UnFollow ", for: .normal)
                    }
                }
            }
        }
        
    }
    @IBAction func btnFirstAction(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        let userId = userDefaults.value(forKey: "otherUser") as! String
        let owner = userDefaults.value(forKey: "owner") as! String
        
        if(userId == owner){
            
            let planStatus = userDefaults.value(forKey: "planStatus") as! Int
            
            if(planStatus >= 2){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AlertPriceVC") as! AlartPriceVC
                vc.getTitle = getTitle
                vc.collectionId = collectionId
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                self.addChildViewController(vc)
                self.view.addSubview(vc.view)
                
            }else {
                let alert = UIAlertController(title: "Alarm", message: "You can not change price", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Understand", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            if(!isFree){
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
                vc.getPrice = (myColInfo!.price)
                vc.getCollectionOwner = (myColInfo!.owner)
                vc.getCurrency = (myColInfo!.cur_en)
                vc.getFaCurrency = (myColInfo!.cur_fa)
                vc.getCollectionId = collectionId
                vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                self.addChildViewController(vc)
                self.view.addSubview(vc.view)
            }else{
                /* let vc = self.storyboard?.instantiateViewController(withIdentifier: "payment") as! PaymentViewController
                 vc.getPrice = (myColInfo!.price)
                 vc.getCollectionOwner = (myColInfo!.owner)
                 vc.getCurrency = (myColInfo!.cur_en)
                 vc.getFaCurrency = (myColInfo!.cur_fa)
                 vc.getCollectionId = collectionId
                 vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                 self.addChildViewController(vc)
                 self.view.addSubview(vc.view)*/
            }
            
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        holeView.isHidden = true
        lblFrom.isHidden = true
        lblInclude.isHidden = true
        getCollectionInfo()
    }
    func show(content : ColInfo){
        
        myColInfo = content
        getName = content.owner_name
        getDegree = content.education
        getTitle = content.title
        getImage = content.profilePic
        
        getStartDate = content.startDate
        folowByMe  = content.followedByMe
        DispatchQueue.main.async{
            self.lblFrom.isHidden = false
            self.lblInclude.isHidden = false
            self.numberOdPost = 3
            self.lblName.text = self.getName
            self.lblDegree.text = self.getDegree
            self.lblTitle.text = self.getTitle
            self.lblCount.text =  String(self.numberOdPost)
            if(self.getStartDate != nil){
                if(self.getStartDate == ""){
                    self.detailView.isHidden = true
                }else{
                      self.lblDate.text = self.getStartDate
                }
            }else{
                self.detailView.isHidden = true
            }
          
            self.imgPerson.layer.cornerRadius = self.imgPerson.frame.size.width/2
            self.imgPerson.clipsToBounds = true
            
            var description = "From " + self.getStartDate + " Make By  " + self.getName + ""
            
            let desc = " is using MyCareerClue to share their valuable experiences. To see Clues, Collections and Resources, please swipe left."
            if(content.description == ""){
                description = description + desc;
            }else{
                description = description + content.description
            }
            
            
            self.lblDescription.text = description
            if(self.getImage != "")
            {
                let url = URL(string : self.getImage)
                
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url!) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                
                                self?.imgPerson.setBackgroundImage(image, for: UIControlState.normal)
                                self?.imgPerson.layoutIfNeeded()
                                self?.imgPerson.subviews.first?.contentMode = .scaleAspectFill
                            }
                        }
                    }
                }
            }
            let userDefaults = UserDefaults.standard
            userDefaults.set(content.owner, forKey: "otherUser")
            let userId = userDefaults.value(forKey: "otherUser") as! String
            let owner = userDefaults.value(forKey: "owner") as! String
            
            if(userId == owner){
                self.btnFirst.setTitle("Pricing", for: .normal)
                
                self.btnFirst.backgroundColor = .white
                self.btnFirst.layer.cornerRadius = 5
                self.btnFirst.layer.borderWidth = 1
                self.btnFirst.layer.borderColor = UIColor.purple.cgColor
                self.btnSecond.backgroundColor = .orange
            }else {
                
                if(content.price != "0"){
                    
                    if( content.boughtByMe == 1){
                        self.isFree = true
                        
                        let index = content.price.index(content.price.startIndex, offsetBy: 2)
                        let one = content.price.prefix(upTo : index)
                        let two = content.price.suffix(from : index)
                        self.btnFirst.setTitle(one + "." + two + " " + content.cur_en, for: .normal)
                        self.btnFirst.setImage(UIImage(named: "check.png"), for: .normal)
                        self.btnSecond.setTitle("UnFollow", for: .normal)
                        self.btnSecond.setImage(UIImage(named: "check.png"), for: .normal)
                        
                    }else {
                        self.btnFirst.setImage(nil, for: .normal)
                        self.btnSecond.setImage(nil, for: .normal)
                        self.btnFirst.setTitle("Payment", for: .normal)
                        self.isFree = false
                    }
                    
                }else{
                    self.btnFirst.setImage(nil, for: .normal)
                    self.btnSecond.setImage(nil, for: .normal)
                    self.btnFirst.setTitle("Free", for: .normal)
                    
                    self.isFree = true
                }
                
                self.btnFirst.backgroundColor = .white
                self.btnFirst.layer.cornerRadius = 5
                self.btnFirst.layer.borderWidth = 1
                self.btnFirst.layer.borderColor = UIColor.purple.cgColor
                
                if(self.folowByMe == 0){
                    self.btnSecond.setTitle("+Follow Collection", for: .normal)
                }else {
                    self.btnSecond.setTitle("UnFollow", for: .normal)
                }
                self.btnSecond.backgroundColor =    UIColor.init(red: 62/256, green: 143/256, blue: 223/256, alpha: 1)
                
            }
            SVProgressHUD.dismiss()
            self.holeView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+100)
            
            self.holeView.isHidden = false
        }
        
    }
    
    @IBOutlet weak var btnFirst: UIButton!
    
    @IBOutlet weak var btnSecond: UIButton!
    
    
    @IBAction func btnShowMe(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let saverList = storyBoard.instantiateViewController(withIdentifier: "saverOfContList") as! SaverOfContributeVC
        saverList.getCollectionId =  collectionId
        saverList.getTitle = getTitle
        self.present(saverList, animated: true, completion: nil)
    }
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "About")
    }
    func getCollectionInfo()  {
        
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.collectionInfo(collectionId,owner)
        {
            (contents, error) in
            if let error = error{
                self.updateError()
                print(error)
                return
            }
            guard let content = contents else{
                self.updateError()
                print("error getting collections")
                return
            }
            self.show(content: content)
        }
        
        
    }
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
        }
    }
}

