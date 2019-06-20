//
//  AddCollectionStepThree.swift
//  WeYouMaster
//
//  Created by alireza on 11/14/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import Dropper
import SearchTextField
import DropDown
import Alamofire

import SwiftMessages
class AddContribution: UIViewController,UICollectionViewDataSource,
    UICollectionViewDelegate,UIImagePickerControllerDelegate,
UINavigationControllerDelegate,UITextViewDelegate {

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    @IBOutlet weak var skillSearchTextField: SearchTextField!
    @IBOutlet weak var dropdown : UIButton!
    @IBOutlet weak var picOne: UIImageView!
    @IBOutlet weak var picTwo: UIImageView!
    @IBOutlet weak var backOne: UIView!
    @IBOutlet weak var backTwo: UIView!
    @IBOutlet weak var backThree: UIView!
    @IBOutlet weak var viewStepTwo: UIView!
    @IBOutlet weak var UIViewThree: UIView!
    @IBOutlet weak var viewStepOne : UIView!
    @IBOutlet weak var lblRtl: UILabel!
    @IBOutlet weak var lblPublic: UILabel!
    @IBOutlet weak var rtlSwitch: UISwitch!
    @IBOutlet weak var publicSwitch: UISwitch!
    @IBOutlet weak var picThree: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgPictureCollection: UIImageView!
    @IBOutlet weak var skilbutton: UIButton!
    @IBOutlet weak var edtTitle : UITextField!
    @IBOutlet weak var edtDesc : UITextView!
    @IBOutlet weak var btnSaveOut: UIButton!
    @IBOutlet weak var viewSteper: UIView!
    
     let dropDown = DropDown()
    var strSelectedSkill = String()
    
    var Profile_photo_link : String = ""
    var Owner: String = ""
    var publicType  = 1
    var rtl = 1
    var step = 1
    var type  = 0
    var count = 1
    var chosenImage = false
    var lastCurrency : String = ""
    var contributionId : String  = ""
    var imageData: Data? = nil
    var activeColor = UIColor.init(red: 73.0/255.0, green: 2/255.0, blue: 78/255.0, alpha: 1.0)
    
    var collectionId = "0"
    var collName = "";
    var isOpen = false
    var isOpenCat = false
    var skilList=[""]
    var collectionList = [""]
    var myCollection : [CollectionOther] = []
    var skilType = [""]
    var myLabeles : [LabelPrototype] = []
    var addedLabeles : [LabelPrototype] = []
    
    
    
    
    var isEdit = Bool()
    var editTitle = String ()
    var editCollection = String()
    var editCollectionTitle = String()
    var editDescription = String()
    var editIsPublic = String()
    var editRtl = String()
    var editContentId = String()
    var editLocation = String()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction func publicToggleChange(_ sender: Any) {
        if publicSwitch.isOn {
            publicType = 1
            lblPublic.text = "عمومی"
        }
        else
        {
            publicType = 0
            lblPublic.text = "خصوصی"
            
        }
    }
    @IBAction func rtlToggleChange(_ sender: Any) {
        if rtlSwitch.isOn {
            rtl = 1
            lblRtl.text = "فارسی"
        }
        else
        {
            lblRtl.text = "انگلیسی"
            rtl = 0
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if edtDesc.textColor == UIColor.lightGray {
            edtDesc.text = ""
            edtDesc.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if edtDesc.text.isEmpty {
            edtDesc.text = " در رابطه با مشارکت برای رصدکنندگان خود توضیح دهید"
            edtDesc.textColor = UIColor.lightGray
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edtDesc.textColor = UIColor.lightGray
        edtDesc.delegate = self
        
        labelCollectionView.dataSource = self
        labelCollectionView.delegate = self
        
        viewStepOne.isHidden=false
        backOne.layer.cornerRadius = backOne.layer.frame.width/2
        backOne.clipsToBounds = true
        
        backTwo.layer.cornerRadius = backTwo.layer.frame.width/2
        backTwo.clipsToBounds = true
        
        backThree.layer.cornerRadius = backThree.layer.frame.width/2
        backThree.clipsToBounds = true
        
        backOne.backgroundColor = activeColor
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        let userDefaults = UserDefaults.standard
        Owner = userDefaults.value(forKey: "owner") as! String
        
        Profile_photo_link = userDefaults.value(forKey: "profilePhoto") as! String
        
        
        
        let url = URL(string: Profile_photo_link)
        
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imgProfile.image = image
                    }
                }
            }
        }
        
        
        
        if(isEdit){
            dropdown.setTitle(editCollectionTitle, for: .normal)
            collectionId = editCollection
            edtTitle.text = editTitle
            edtDesc.text = editDescription
            contributionId = editContentId
            if(editRtl == "rtl"){
                lblRtl.text = "فارسی"
                rtl = 1
                rtlSwitch.isOn = true
            }else{
                lblRtl.text = "انگلیسی"
                rtl = 0
                rtlSwitch.isOn = false
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func imgBackAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getLabeles(){
        
        WebCaller.getLabeles { (labeles, error) in
            if let error = error{
                
                print(error)
                return
            }
            guard let labeles = labeles else{
                
                print("error getting labeles")
                return
            }
            self.skilType.remove(at: 0)
            self.skilList.remove(at: 0)
            for label in labeles.labels{
                self.myLabeles.append(label)
                self.skilList.append(label.title)
                if(!self.skilType.contains(label.type))
                {
                    self.skilType.append(label.type)
                }
            }
            self.updateUI()
            
            
        }
    }
    @IBAction func btnAddSkillPush(_ sender: Any) {
        if(skillSearchTextField.text != ""){
            let text = skilbutton.titleLabel?.text
            if(text != "انتخاب دسته"){
                let labbel = LabelPrototype(type: text ?? "", title: skillSearchTextField.text ?? "")
                skillSearchTextField.text = ""
                skilbutton.setTitle("انتخاب دسته", for: .normal)
                
                addedLabeles.append(labbel)
                
                DispatchQueue.main.async{
                    self.labelCollectionView.reloadData()
                    //self.alertController.dismiss(animated: true, completion: nil);
                    
                }
                
            }
        }
    }
    @IBAction func skillPush(_ sender: Any) {
        dropDown.selectionAction = { [unowned self ] (index: Int, item : String) in
            
            self.strSelectedSkill = item
            self.skilbutton.setTitle(item, for: .normal)
            self.filterList()
            self.dropDown.hide()
            
        }
        dropDown.customCellConfiguration = {(index, item, cell:DropDownCell) ->Void in cell.optionLabel.textAlignment = .center}
        dropDown.width = 300
        dropDown.show()
    }
    @IBAction func choseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
        //  present(self.imagePicker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let imageInfo : NSDictionary = info as NSDictionary
        let image = imageInfo.object(forKey: UIImagePickerControllerOriginalImage) as! UIImage
        imgPictureCollection.image = image
        
        self.imageData = UIImagePNGRepresentation(image)!
        chosenImage = true
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func DropperSelectedRow(_ path: IndexPath, contents: String) {
        if(count==1){
            dropdown.setTitle(contents, for: .normal)
            collectionId = myCollection[path.item].collectionId
        }else{
            skilbutton.setTitle(contents, for: .normal)
            filterList()
        }
    }
    func filterList() {
        skilList.removeAll()
        for label in myLabeles {
            if label.type == skilbutton.title(for: .normal)
            {
                skilList.append(label.title)
            }
        }
        makeSearchList()
    }
    
    func updateUI(){
        // first we add dropper
        dropDown.anchorView = skilbutton
        dropDown.dataSource = skilType
        dropDown.cornerRadius = 10
        makeSearchList()
         DispatchQueue.main.async{
        self.loadingView.isHidden = true
        }
        // second we add search list
    }
    
    
    func makeSearchList()  {
        skillSearchTextField.filterStrings(skilList)
        
        skillSearchTextField.theme = SearchTextFieldTheme.darkTheme()
        
        // Modify current theme properties
        skillSearchTextField.theme.borderColor = UIColor.white
        skillSearchTextField.theme.separatorColor = UIColor.white
        skillSearchTextField.theme.bgColor = UIColor.init(red: 73.0/255.0, green: 2.0/255.0, blue: 78.0/255.0, alpha: 1.0); skillSearchTextField.theme.cellHeight = 50
        
        // Set specific comparision options - Default: .caseInsensitive
        skillSearchTextField.comparisonOptions = [.caseInsensitive]
        
        // Set the max number of results. By default it's not limited
        skillSearchTextField.maxNumberOfResults = 10
        
        // You can also limit the max height of the results list
        skillSearchTextField.maxResultsListHeight = 600
    }
    
    
    @IBAction func btnSave(_ sender: Any) {
        if count==1 {
            addContribute()
            //addCollection()
            
        }else if count==2{
            if(chosenImage){
                
                upload()
               // stepThree()
            }else{
                stepThree()
            }
        }else if(count == 3){
            addLabeles()
        }
    }
    func upload() {
        
        
        
        
        loadingView.isHidden = false
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let fileName = "img_" + String(myTimeInterval) + "_" + contributionId + ".png"
        let parameters: Parameters = [
            "contributionId" : contributionId,
            "filename":fileName
        ]
        WebCaller.uploadImageToCollection(imageData: self.imageData, parameters: parameters){
            (resp , error) in
            if let error = error{
                print(error)
                 DispatchQueue.main.async{
                self.loadingView.isHidden = true
                }
                return
            }
            self.stepThree()
            
        }
    }
    
    
     func deleteItem( index : Int){
        self.addedLabeles.remove(at: index)
        DispatchQueue.main.async{
            self.labelCollectionView.reloadData()
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedLabeles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as! LabelViewCell
        let label = addedLabeles[indexPath.item]
        cell.lblName.text = label.title
        cell.lblType.text = label.type
        cell.onButtonTapped = {
            self.deleteItem (index: indexPath.item)
        }
        return cell
    }
    func addContribute() {
        
        if(isEdit){
            
            if(self.edtTitle.text != ""){
                
                loadingView.isHidden = false
                let userDefaults = UserDefaults.standard
                let owner = userDefaults.value(forKey: "owner") as! String
                let contentType = userDefaults.value(forKey: "selectedType")
                WebCaller.editFeed(contributionId : editContentId ,owner: owner,collectionId: collectionId, title: self.edtTitle.text!, description: self.edtDesc.text!, isPublic: publicType, isRtl: rtl,contentType:contentType as! String, link: "")
                { (answer, error) in
                    if let error = error{
                        
                        print(error)
                        self.showError()
                        
                        return
                    }
                    guard let answer = answer else{
                        
                        print("error getting labeles")
                        return
                    }
                    
                    if(answer.error==0){
                        
                        
                        self.stepTwo()
                    }else{
                        self.showError()
                    }
                    
                    
                }
            }
        }else{
        
        if(self.edtTitle.text != ""){
            
            loadingView.isHidden = false
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            let contentType = userDefaults.value(forKey: "selectedType")
            WebCaller.saveFeed(owner: owner,collectionId: collectionId, title: self.edtTitle.text!, description: self.edtDesc.text!, isPublic: publicType, isRtl: rtl,contentType:contentType as! String, link: "")
            { (answer, error) in
                if let error = error{
                    
                    print(error)
                    self.showError()
                    
                    return
                }
                guard let answer = answer else{
                    
                    print("error getting labeles")
                    return
                }
                
                if(answer.error==0){
                    
                    self.contributionId = answer.contributionId
                    self.stepTwo()
                }else{
                    self.showError()
                }
                
                
            }
        }
        }
    }
    
    func stepTwo()  {
        DispatchQueue.main.async{
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
            
            self.loadingView.isHidden = true
            self.viewStepOne.isHidden = true
            self.UIViewThree.isHidden = true
            self.viewStepTwo.isHidden = false
            self.lblRtl.isHidden = true
            self.lblPublic.isHidden = true
            self.rtlSwitch.isHidden = true
            self.publicSwitch.isHidden = true
            self.backTwo.backgroundColor = self.activeColor
            self.count = 2
        }
    }
    func stepThree()  {
        DispatchQueue.main.async{
            
            //self.alertController.dismiss(animated: true, completion: nil);
            self.getLabeles()
            self.lblPublic.text  = "step two" + String(self.count)
            self.viewStepOne.isHidden = true
            self.viewStepTwo.isHidden = true
            self.UIViewThree.isHidden = false
            self.backThree.backgroundColor = self.activeColor
            self.count = 3
        }
    }
    func addLabeles(){
        if(self.addedLabeles.count>0){
            self.loadingView.isHidden = false
            var finalLabel : String
            finalLabel = "["
            let jsonEncoder = JSONEncoder()
            for label in addedLabeles {
                
                
                do {
                    let jsonData = try jsonEncoder.encode(label)
                    let jsonString = String(data: jsonData, encoding: .utf8)
                    finalLabel = finalLabel + jsonString!
                    finalLabel = finalLabel + ","
                    //all fine with jsonData here
                } catch {
                    //handle error
                    print(error)
                }
                
                
            }
            
            finalLabel.removeLast()
            finalLabel = finalLabel + "]"
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            
            WebCaller.addLabelContribution(owner, contributionId, finalLabel){
                (answer, error) in
                if let error = error{
                    
                    print(error)
                    self.showError()
                    return
                }
                guard let answer = answer else{
                    self.showError()
                    print("error getting labeles")
                    return
                }
                
                if(answer.error==0){
                    
                    self.stepFinish()
                }else{
                    self.showError()
                }
                
                
            }
            
            
        }
    }
    func stepFinish() {
        
        DispatchQueue.main.async{
            self.loadingView.isHidden = true
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func showError(){
        DispatchQueue.main.async{
            self.loadingView.isHidden = true
        }
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        view.configureContent(title: "خطا", body: "در ارسال اطلاعات خطایی رخ داده لطفا ورودی ها را بررسی کرده و مجددا تلاش کنید.", iconText: iconText)
        view.iconImageView?.isHidden = true
        view.button?.isHidden = true
        view.semanticContentAttribute = .forceRightToLeft
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        
        // Show the message.
        
        SwiftMessages.show(view: view)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        let userDefaults = UserDefaults.standard
        
        if(collName != ""){
            dropdown.setTitle(collName, for: .normal)
            collName = ""
        }else{
            collectionId = userDefaults.value(forKey: "selectedCollection") as! String
            
            if(collectionId != "0"){
                
                if(collName != ""){
                    
                }else{
                    let collectionName = userDefaults.value(forKey: "selectedCollectionName")
                    dropdown.setTitle(collectionName as? String, for: .normal)
                }
            }
        }
        
        
    }
    @IBAction func btnChose(_ sender: Any) {
        
        let stroyBoard = UIStoryboard(name: "Main", bundle: nil)
        let add = stroyBoard.instantiateViewController(withIdentifier: "selectcollectionchapter" ) as? SelectCollectionAndChapterVC
        
        
        self.present(add!, animated: true, completion: nil)
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
