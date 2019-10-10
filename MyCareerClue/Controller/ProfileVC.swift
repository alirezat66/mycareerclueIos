//
//  ProfileVC.swift
//  WeYouMaster
//
//  Created by alireza on 8/5/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import JJFloatingActionButton
import SVProgressHUD
import Alamofire

extension UIViewController {
  
    
}
class ProfileVC: UIViewController,UITextFieldDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
    
    @IBOutlet weak var txtAboat: UITextView!
    
    @IBAction func btnEdit(_ sender: Any) {
        if(imageData != nil){
            uploadImage();
        }else{
            editProfile()
        }
        
    }
    @IBOutlet weak var imgPerson: UIImageView!
    
    @IBOutlet weak var edtLName: UITextField!
    @IBOutlet weak var edtName: UITextField!
    @IBOutlet weak var edtRole: UITextField!
    @IBOutlet weak var edtLocation: UITextField!
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddLink(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "alertDedicated") as! AlertDedicatedLink
        vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addChildViewController(vc)
        self.view.addSubview(vc.view)
    }
    var getName = String()
    var getLName = String()

    var getCity = String()
    var getRole = String()
    var getImage = String()
    var profileId = String()
    var getOwner = String()
    var bio = String()
    var chosenImage = false
    var imageData: Data? = nil
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imageInfo : NSDictionary = info as NSDictionary
        let image = imageInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        
        imgPerson.image = image
        self.imageData = ProfileVC.resize(image: image, maxHeight: 600, maxWidth: 800, compressionQuality: 0.6)
       //  = UIImagePNGRepresentation(image)!
        chosenImage = true
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    @objc public func DismissKeyboard(){
        view.endEditing(true)
    }
    var onDoneBlock : ((Bool) -> Void)?
    
    func addDoneButtonOnKeyboard()
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.edtLName.inputAccessoryView = doneToolbar
        self.edtName.inputAccessoryView = doneToolbar
        self.edtRole.inputAccessoryView = doneToolbar
        self.edtLocation.inputAccessoryView = doneToolbar
        self.txtAboat.inputAccessoryView = doneToolbar
        
    }
    @objc func doneButtonAction(){
        self.edtLName.resignFirstResponder()
        self.edtName.resignFirstResponder()
        self.edtRole.resignFirstResponder()
        self.edtLocation.resignFirstResponder()
        self.txtAboat.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        let tab : UITapGestureRecognizer = UITapGestureRecognizer(target : self , action : #selector(DismissKeyboard))
        view.addGestureRecognizer(tab)
        edtName.layer.borderColor  = UIColor.orange.cgColor
        edtLName.layer.borderColor = UIColor.orange.cgColor
        edtRole.layer.borderColor = UIColor.orange.cgColor
        edtLocation.layer.borderColor  = UIColor.orange.cgColor
        txtAboat.layer.borderColor = UIColor.orange.cgColor
        imgPerson.layer.cornerRadius = imgPerson.frame.size.width/2
        imgPerson.clipsToBounds = true
        
        edtName.text = getName
        edtLName.text = getLName
        edtRole.text = getRole
        edtLocation.text = getCity
        txtAboat.text = bio
        imageFromServerURL(urlString: getImage)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        imgPerson?.isUserInteractionEnabled = true
        imgPerson?.addGestureRecognizer(tapGestureRecognizer)
        
       /* lblNumber.text = phoneNumber
        imgProfile.image  = UIImage.init(named: "add_user_pn.png")
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width/2
        imgProfile.clipsToBounds = true*/
       
        
        
        
        
        
     

        // Do any additional setup after loading the view.
    }

    func imageFromServerURL(urlString: String) {
        self.imgPerson.image = UIImage.init(named:"avatar_icon.png" )
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                
                return
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.imgPerson.image = image
            })
            
        }).resume()
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
    }
    
    func editProfile(){
        SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
        WebCaller.editProfile(getOwner,edtName.text!,edtLName.text!,edtRole.text!,edtLocation.text!,txtAboat.text!) {
            (errorMessage , error) in
            if let error  = error {
                print(error)
                self.updateError()
                return
            }
            guard let errorMessage = errorMessage else {
                print("error getting collections")
                self.updateError()
                return
            }
            if(errorMessage.error == 0){
                self.updateUI()
            }   else
            {
                self.updateError()
            }
            
        }
    }
    static func resize(image: UIImage, maxHeight: Float = 500.0, maxWidth: Float = 500.0, compressionQuality: Float = 0.5) -> Data? {
        var actualHeight: Float = Float(image.size.height)
        var actualWidth: Float = Float(image.size.width)
        var imgRatio: Float = actualWidth / actualHeight
        let maxRatio: Float = maxWidth / maxHeight
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: CGFloat(actualWidth), height: CGFloat(actualHeight))
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in:rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = UIImageJPEGRepresentation(img!,CGFloat(compressionQuality))
        UIGraphicsEndImageContext()
        return imageData
    }
    func uploadImage() {
         SVProgressHUD.show(withStatus: "Please Wait ... \n\n")
            let timestamp = NSDate().timeIntervalSince1970
            let myTimeInterval = TimeInterval(timestamp)
        
            let fileName = getOwner + "_u_1.jpg"
            let parameters: Parameters = [
            "owner_id" : getOwner,
            "filename":fileName
            ]
        
        WebCaller.uploadImageToProfile(imageData: self.imageData, parameters: parameters){
            (resp , error) in
            if let error = error{
                print(error)
                self.updateError()
                return
            }
            let userDefaults = UserDefaults.standard
            userDefaults.set(resp?.filename, forKey: "profilePhoto")
            userDefaults.set(true, forKey: "imageUpdated")
            
            DispatchQueue.main.async{
                SVProgressHUD.dismiss()
                self.editProfile()
            }
           
            
        }
        
        
    }
    
   
    func updateError(){
        DispatchQueue.main.async{
            SVProgressHUD.dismiss()
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func updateUI(){
        
        
        
        
        
        DispatchQueue.main.async{
        
            
            //  self.goToLast()
            let userDefaults = UserDefaults.standard
            userDefaults.set(self.getOwner, forKey: "owner")
            userDefaults.set(self.edtName.text!, forKey: "fName")
            userDefaults.set(self.edtRole.text!, forKey: "industry")
            userDefaults.set(self.edtLocation.text!, forKey: "City")
            userDefaults.set(self.edtRole.text!, forKey: "job")
            userDefaults.set(self.edtLName.text!, forKey: "lName")
            userDefaults.set(self.txtAboat.text!, forKey: "bio")
            SVProgressHUD.dismiss()
            self.onDoneBlock!(true)
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    @IBOutlet weak var bottomText: NSLayoutConstraint!

   
}
