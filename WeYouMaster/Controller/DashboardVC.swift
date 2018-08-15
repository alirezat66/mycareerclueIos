

import UIKit

class DashboardVC: UIViewController {

    
 
    
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblrole: UILabel!
    @IBOutlet weak var lblPlace: UILabel!
    @IBOutlet weak var lblSale: UILabel!
    @IBAction func btnLinkDin(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var Owner: String = ""
        var First_Name: String
        var Last_Name: String
        var Industry : String
        var Job_Position : String
        var City : String
        var Email : String
        var Profile_photo_link : String
        var total_contributions : Int
        var Website : String
        var Sold_sofar : String
        
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.size.width/2
        imgProfile.clipsToBounds = true
         let userDefaults = UserDefaults.standard
        Owner = userDefaults.value(forKey: "owner") as! String
        First_Name = userDefaults.value(forKey: "fName") as! String
        Last_Name = userDefaults.value(forKey: "lName") as! String
        Industry  = userDefaults.value(forKey: "industry") as! String
        
        Job_Position = userDefaults.value(forKey: "job") as! String
        City = userDefaults.value(forKey: "City") as! String
        Email = userDefaults.value(forKey: "email") as! String
        Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        total_contributions = userDefaults.value(forKey: "totalPost") as! Int
        
        Website = userDefaults.value(forKey: "webSite") as! String
        Sold_sofar = userDefaults.value(forKey: "sales") as! String
     
        
        lblName.text = First_Name + " " + Last_Name
        lblrole.text = Industry
        lblPlace.text = City
        lblSale.text = Sold_sofar
        
        // Do any additional setup after loading the view.
    }

    @IBAction func openLinkedIn(_ sender: Any) {
         let userDefaults = UserDefaults.standard
        var LinkedIn : String
        LinkedIn = userDefaults.value(forKey: "linkedIn") as! String
        UIApplication.shared.open(URL(string: LinkedIn)!, options: [:])

    }
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true,completion: nil)
    }
    
}
