//
//  CollectionDetailVCTwo.swift
//  WeYouMaster
//
//  Created by alireza on 9/25/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import XLPagerTabStrip

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
        lblName.text = getName
        lblDegree.text = getDegree
        lblTitle.text = getTitle
        lblCount.text =  String(numberOdPost)
        lblDate.text = getStartDate
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        
        let description = "این مجموعه در تاریخ " + getStartDate + " توسط " + getName + " تولید شده است.جهت مشاهده محتوا و منابع بکار گرفته شده در این مجموعه، سایر صفحات را ملاحظه کنید. ضمنا، محتویات این مجموعه متناسب با نوع مشارکت ها در تب انواع قابل مشاهده است."
        lblDescription.text = description
        if(getImage != "")
        {
            let url = URL(string : getImage)
            
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url!) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                          
                            self?.imgPerson.setBackgroundImage(image, for: UIControlState.normal)
                            
                        }
                    }
                }
            }
        }
        
        
    }

    

    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: "درباره")
    }
}
