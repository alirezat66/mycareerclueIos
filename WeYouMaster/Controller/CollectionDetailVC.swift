//
//  CollectionDetailVC.swift
//  WeYouMaster
//
//  Created by alireza on 7/21/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit

class CollectionDetailVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DataService.instance.getContent().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") as? DetailCell{
            let content = DataService.instance.getContent()[indexPath.row]
        cell.updateView(content: content)
        return cell
        }else {
            return DetailCell()
        }
    }
    

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    var getName = String()
    var getCity = String()
    var getTitle = String()
    var getImage = UIImage()
    
    @IBOutlet weak var contentTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblName.text = getName
        lblCity.text = getCity
        lblTitle.text = getTitle
        imgPerson.image = getImage
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        contentTable.dataSource = self
        contentTable.delegate = self
        // Do any additional setup after loading the view.
    }

  
}
