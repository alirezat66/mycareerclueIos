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
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "لطفا منتظر بمانید ... \n\n")
        holeView.isHidden = true
        getCollectionInfo()
    }
    func show(content : ColInfo){
        

        getName = content.owner_name
         getDegree = content.education
         getTitle = content.title
        getImage = content.profilePic
        
         getStartDate = content.startDate
        
        DispatchQueue.main.async{
            
            self.numberOdPost = 3
            self.lblName.text = self.getName
            self.lblDegree.text = self.getDegree
            self.lblTitle.text = self.getTitle
            self.lblCount.text =  String(self.numberOdPost)
            self.lblDate.text = self.getStartDate
            self.imgPerson.layer.cornerRadius = self.imgPerson.frame.size.width/2
            self.imgPerson.clipsToBounds = true
            
            var description = "این مجموعه در تاریخ " + self.getStartDate + " توسط " + self.getName + " تولید شده است."
            
            let desc = "جهت مشاهده محتوا و منابع بکار گرفته شده در این مجموعه، سایر صفحات را ملاحظه کنید. ضمنا، محتویات این مجموعه متناسب با نوع مشارکت ها در تب انواع قابل مشاهده است."
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
            let userId = userDefaults.value(forKey: "otherUser") as! String
            let owner = userDefaults.value(forKey: "owner") as! String
            
            if(userId == owner){
                self.btnFirst.setTitle("قیمت گذاری", for: .normal)
                
                self.btnFirst.backgroundColor = .white
                self.btnFirst.layer.cornerRadius = 5
                self.btnFirst.layer.borderWidth = 1
                self.btnFirst.layer.borderColor = UIColor.purple.cgColor
                self.btnSecond.backgroundColor = .orange
            }else {
                self.btnFirst.setTitle("رایگان", for: .normal)
                self.btnFirst.setImage(nil, for: .normal)
                self.btnFirst.backgroundColor = .white
                self.btnFirst.layer.cornerRadius = 5
                self.btnFirst.layer.borderWidth = 1
                self.btnFirst.layer.borderColor = UIColor.purple.cgColor
                self.btnSecond.setTitle("+رصد مجموعه", for: .normal)
                self.btnSecond.backgroundColor =    UIColor.init(red: 62/256, green: 143/256, blue: 223/256, alpha: 1)

            }
            SVProgressHUD.dismiss()
            self.holeView.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+100)

            self.holeView.isHidden = false
        }
        
    }
    @IBOutlet weak var btnFirst: UIButton!
    
    @IBOutlet weak var btnSecond: UIButton!
    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "درباره")
    }
    func getCollectionInfo()  {
        
        
        WebCaller.collectionInfo(collectionId)
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
