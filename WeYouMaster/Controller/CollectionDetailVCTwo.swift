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

        getCollectionInfo()
    }
    func show(content : ColInfo){
        

        getName = content.owner_name
         getDegree = content.education
         getTitle = content.title
        getImage = content.profilePic
        
         getStartDate = content.startDate
         numberOdPost = 3
        lblName.text = getName
        lblDegree.text = getDegree
        lblTitle.text = getTitle
        lblCount.text =  String(numberOdPost)
        lblDate.text = getStartDate
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        
        var description = "این مجموعه در تاریخ " + getStartDate + " توسط " + getName + " تولید شده است."
        
          var desc = "جهت مشاهده محتوا و منابع بکار گرفته شده در این مجموعه، سایر صفحات را ملاحظه کنید. ضمنا، محتویات این مجموعه متناسب با نوع مشارکت ها در تب انواع قابل مشاهده است."
        if(content.description == ""){
            description = description + desc;
        }else{
            description = description + content.description
        }
        
      
        lblDescription.text = description
        if(getImage != "")
        {
            let url = URL(string : getImage)
            
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
            btnFirst.setTitle("قیمت گذاری", for: .normal)
            
            btnFirst.backgroundColor = .white
            btnFirst.layer.cornerRadius = 5
            btnFirst.layer.borderWidth = 1
            btnFirst.layer.borderColor = UIColor.purple.cgColor
            btnSecond.backgroundColor = .orange
        }else {
            btnFirst.setTitle("رایگان", for: .normal)
            
            btnFirst.backgroundColor = .white
            btnFirst.layer.cornerRadius = 5
            btnFirst.layer.borderWidth = 1
            btnFirst.layer.borderColor = UIColor.purple.cgColor
            btnSecond.setTitle("+رصد مجموعه", for: .normal)
            btnSecond.backgroundColor = .orange
        }
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
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
