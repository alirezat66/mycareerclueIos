//
//  AddCollectionVC.swift
//  WeYouMaster
//
//  Created by alireza on 11/13/18.
//  Copyright © 2018 alireza. All rights reserved.
//



import UIKit
import Dropper
import SearchTextField
import Photos
import Alamofire
import SwiftyJSON
import DropDown


class AddCollectionVC: UIViewController,UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate
    {
    
    
    var strSelectedSkill = String()
    
    var editCollectionTitle = String()
    var editCollectionDesc  = String()
    var editCollectionId    = String()
    var editPrice    = String()
    let dropDown = DropDown()
    var type = Int() // 0 for add 1 for edit
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    @IBOutlet weak var stackOfUiOne: UIStackView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedLabeles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as! LabelViewCell
        let label = addedLabeles[indexPath.item]
        cell.lblName.text = label.title
        cell.lblType.text = label.type
        return cell
    }
    

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    
    @IBOutlet weak var skillSearchTextField: SearchTextField!
    @IBOutlet weak var dropdown : UIButton!

    
    @IBAction func imgBackAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var picTwo: UIImageView!
    @IBOutlet weak var backOne: UIView!
    @IBOutlet weak var backThree: UIView!
    @IBOutlet weak var viewStepFour: UIView!
    @IBOutlet weak var viewStepTwo: UIView!
    @IBOutlet weak var UIViewThree: UIView!
    @IBOutlet weak var audOut: DLRadioButton!
    @IBOutlet weak var cadOut: DLRadioButton!
    @IBOutlet weak var usdOut: DLRadioButton!
    @IBOutlet weak var irrOut: DLRadioButton!
    
    @IBOutlet weak var edtPriceDec: UITextField!
    @IBOutlet weak var viewStepOne
    : UIView!
    @IBOutlet weak var eurOut: DLRadioButton!
    @IBOutlet weak var edtPrice: UITextField!
    @IBOutlet weak var lblRtl: UILabel!
    @IBOutlet weak var lblPublic: UILabel!
    @IBOutlet weak var rtlSwitch: UISwitch!
    @IBOutlet weak var publicSwitch: UISwitch!
    @IBOutlet weak var picThree: UIImageView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgPictureCollection: UIImageView!
    @IBOutlet weak var skilbutton: UIButton!
    var Profile_photo_link : String = ""
    var Owner: String = ""
    var publicType  = 1
    var rtl = 1
    var step = 1
    var count = 1
    var chosenImage = false
    var lastCurrency : String = ""
    var imageData: Data? = nil
    var activeColor = UIColor.init(red: 73.0/255.0, green: 2/255.0, blue: 78/255.0, alpha: 1.0)
    @IBOutlet weak var edtTitle : UITextField!
    
    
  
    
    var collectionId = ""
    var isOpen = false
    var isOpenCat = false
    var catList = ["مدیریت","منابع انسانی","فنی و مهندسی","فروش و بازاریابی","هنر","پزشکی","سایر"]
    
    var skilList=[""]
    var skilType = [""]
    var myLabeles : [LabelPrototype] = []
    var addedLabeles : [LabelPrototype] = []

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
                    //dropper.delegate self.alertController.dismiss(animated: true, completion: nil);
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
       /* if dropperType.status == .hidden {
            dropper.delegate = self
            dropperType.showWithAnimation(0.25, options: Dropper.Alignment.center, button: skilbutton)
            UIViewThree.addSubview(dropperType)
        } else {
            dropperType.hideWithAnimation(0.2)
        }*/
    }
    @IBAction func choseImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker,animated: true,completion: nil)
      //  present(self.imagePicker, animated: true, completion: nil)
        
        
    }
    @IBAction func audSelect(_ sender: Any) {
        lastCurrency = "aud"
        checkSetting()
    }
    @IBAction func cadSelect(_ sender: Any) {
        lastCurrency = "cad"
        checkSetting()
    }
    @IBAction func eurSelect(_ sender: Any) {
        lastCurrency = "eur"
        checkSetting()
    }
    @IBAction func usdSelect(_ sender: Any) {
        lastCurrency = "usd"
        checkSetting()
    }
    @IBAction func irrSelect(_ sender: Any) {
        lastCurrency = "irr"
        checkSetting()
    }
    func checkSetting(){
        if(lastCurrency == "aud"){
            audOut.isSelected = true
            cadOut.isSelected = false
            eurOut.isSelected = false
            usdOut.isSelected = false
            irrOut.isSelected = false
        }else if(lastCurrency == "cad"){
            audOut.isSelected = false
            cadOut.isSelected = true
            eurOut.isSelected = false
            usdOut.isSelected = false
            irrOut.isSelected = false
        }else if(lastCurrency == "eur"){
            audOut.isSelected = false
            cadOut.isSelected = false
            eurOut.isSelected = true
            usdOut.isSelected = false
            irrOut.isSelected = false
        }else if(lastCurrency == "usd"){
            audOut.isSelected = false
            cadOut.isSelected = false
            eurOut.isSelected = false
            usdOut.isSelected = true
            irrOut.isSelected = false
        }else if(lastCurrency == "irr"){
            audOut.isSelected = false
            cadOut.isSelected = false
            eurOut.isSelected = false
            usdOut.isSelected = false
            irrOut.isSelected = true
        }
    }
    
    @IBAction func btnChose(_ sender: Any) {
        edtDesc.delegate = nil
        dropDown.dataSource = catList
        dropDown.selectionAction = { [unowned self ] (index: Int, item : String) in
            self.dropdown.setTitle(item, for: .normal)
            self.dropDown.hide()
            self.edtDesc.delegate = self
            
        }
        dropDown.customCellConfiguration = {(index, item, cell:DropDownCell) ->Void in cell.optionLabel.textAlignment = .center}
        dropDown.width = 300
        dropDown.show()
        
     /*   if dropper.status == .hidden {
            dropper.items = catList // Items to be displayed
            dropper.theme = Dropper.Themes.black(nil)
            dropper.cornerRadius = 10
            dropper.spacing = 20
            dropper.border = (width: 2, color: UIColor.white)
            
            dropper.delegate = self

            dropper.showWithAnimation(0.25, options: Dropper.Alignment.center, button: dropdown)
            viewStepOne.addSubview(dropper)
        } else {
            dropper.hideWithAnimation(0.2)
        }*/
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
    
    @IBOutlet weak var edtDesc : UITextView!
  
    @objc func keyboardWillShow(notification:NSNotification)
    {
        if let info = notification.userInfo{
            let _:CGRect = info["UIKeyboardFrameEndUserInfoKey"] as! CGRect
            self.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.25, animations: {
                self.view.layoutIfNeeded()
                
            })
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
            edtDesc.text = " در رابطه با مجموعه برای رصدکنندگان خود توضیح دهید"
            edtDesc.textColor = UIColor.lightGray
        }
    }
    
    func addCollection() {
        
        if(self.edtTitle.text != ""){
        
        loadingView.isHidden = false
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
            
            
        if(type == 0){
        WebCaller.saveCollection(owner: owner, title: self.edtTitle.text!, description: self.edtDesc.text!, isPublic: publicType, isRtl: rtl, link: "")
        { (answer, error) in
            if let error = error{
                print(error)
                return
            }
            guard let answer = answer else{
                
                print("error getting labeles")
                return
            }
            if(answer.error==0){
                self.collectionId = answer.collectionId
                self.stepFour()
            }
        }
        
        }else {
            WebCaller.editCollection(owner: owner,collectionId: editCollectionId, title: self.edtTitle.text!, description: self.edtDesc.text!, isPublic: publicType, isRtl: rtl, link: "")
            { (answer, error) in
                if let error = error{
                    
                    print(error)
                    return
                }
                guard let answer = answer else{
                    
                    print("error getting labeles")
                    return
                }
                
                if(answer.error==0){
                    self.collectionId = self.editCollectionId
                    self.stepFour()
                }
                
                
            }
        }
    }
    }
    
    
    func addLabeles(){
        if(self.addedLabeles.count>0){
            self.loadingView.isHidden = false
            var finalLabel : String
            finalLabel = "["
            let jsonEncoder = JSONEncoder()
            for label in myLabeles {
                
                
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
            
            WebCaller.addLabel(owner, collectionId, finalLabel){
                (answer, error) in
                if let error = error{
                    
                    print(error)
                    return
                }
                guard let answer = answer else{
                    
                    print("error getting labeles")
                    return
                }
                
                if(answer.error==0){
                    
                    self.stepFour()
                }
                
                
            }
            
            
        }
    }
    func addPrice(){
        if(edtPrice.text==""){
             self.stepFinish()
        }else {
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            self.loadingView.isHidden = false
        WebCaller.addPrice(_owner: owner, _collectionId: collectionId, _price: edtPrice.text!, _currency: lastCurrency, _desc:  edtPriceDec.text!){
                (answer, error) in
                if let error = error{
                    print(error)
                    return
                }
                guard let answer = answer else{
                    
                    print("error getting labeles")
                    return
                }
                
                if(answer.error==0){
                    
                    self.stepFinish()
                }
                
                
            }
        }
            
            
        
    }
    func stepFinish() {
        DispatchQueue.main.async{
        self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var btnSaveOut: UIButton!
    @IBOutlet weak var viewSteper: UIView!
    func stepFour()  {
        DispatchQueue.main.async{
            
            //self.alertController.dismiss(animated: true, completion: nil);
            
            
            self.loadingView.isHidden = true
            self.count = 4
            self.uiBottom.isHidden = true
            self.viewStepOne.isHidden = true
            self.viewStepTwo.isHidden = true
            self.UIViewThree.isHidden = true
            self.viewStepFour.isHidden = false
            self.viewSteper.isHidden = true
            self.btnSaveOut.setTitle("اتمام", for: .normal)
            self.edtPrice.text = self.editPrice
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
            self.count = 2
        }
    }
    
    func stepThree()  {
        DispatchQueue.main.async{
            
            //self.alertController.dismiss(animated: true, completion: nil);
            self.edtDesc.delegate = nil
            
            self.lblPublic.text  = "step two" + String(self.count)
            self.viewStepOne.isHidden = true
            self.viewStepTwo.isHidden = true
            self.UIViewThree.isHidden = false
            self.backThree.backgroundColor = self.activeColor
            self.count = 3
            self.getLabeles()
        }
    }
    @IBAction func btnSave(_ sender: Any) {
        if count==1 {
            
            addCollection()
            
        }else if count==2{
            if(chosenImage){
                //upload()
                stepThree()
            }else{
                stepThree()
            }
        }else if(count == 3){
            addLabeles()
        }else {
            
                if(edtPrice.text == ""){
                    dismiss(animated: true, completion: nil)
                }else{
                   addPrice()
                }
            }
        }
        
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDown.anchorView = dropdown
        let tab : UITapGestureRecognizer = UITapGestureRecognizer(target : self , action : #selector(DismissKeyboard))
        view.addGestureRecognizer(tab)
        edtDesc.textColor = UIColor.lightGray
        edtDesc.delegate = self
        labelCollectionView.dataSource = self
        labelCollectionView.delegate = self
       
        viewStepOne.isHidden=false
        backOne.layer.cornerRadius = backOne.layer.frame.width/2
        backOne.clipsToBounds = true
        
       
        
        backThree.layer.cornerRadius = backThree.layer.frame.width/2
        backThree.clipsToBounds = true
    
        backOne.backgroundColor = activeColor
        imgProfile.layer.cornerRadius = imgProfile.layer.frame.size.width/2
        imgProfile.clipsToBounds = true
        
        
       
        // make ui
        
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
        
        edtDesc.textColor = UIColor.lightGray

      
        if(editCollectionId != ""){
            type = 1 //edit
            edtTitle.text =  editCollectionTitle
            edtDesc.text = editCollectionDesc
            edtDesc.textColor = UIColor.black
            collectionId = editCollectionId
        }else{
            type = 0 // add
        }
        
        
        
      
    
    

    }
    
    
    func upload() {
        
        
        
        
        loadingView.isHidden = false
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let fileName = "img_" + String(myTimeInterval) + "_" + collectionId + ".png"
        let parameters: Parameters = [
            "collectionId" : collectionId,
            "file_name":fileName
        ]
        WebCaller.uploadImageToCollection(imageData: self.imageData, parameters: parameters){
            (resp , error) in
            if let error = error{
                print(error)
                self.loadingView.isHidden = true
                return
            }
            self.stepThree()
            
        }
    }
    func errorImage() -> Void{
    
    }
    func completeImageLoad(json:JSON) -> Void {
        
    }
    
    func filterList() {
        skilList.removeAll()
        for label in myLabeles {
            if label.type == strSelectedSkill
            {
                skilList.append(label.title)
            }
        }
        makeSearchList()
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
    @IBAction func btnFinish(_ sender: Any) {
        addPrice()
    }
    @IBOutlet weak var uiBottom: UIView!
    func updateUI(){
        
        dropDown.anchorView = skilbutton
        dropDown.dataSource = skilType
        dropDown.cornerRadius = 10
        // first we add dropper
        /*dropperType.items = skilType // Items to be displayed
        dropperType.delegate = self
        dropperType.theme = Dropper.Themes.black(nil)
        dropperType.cornerRadius = 10
        dropperType.spacing = 20
        dropperType.border = (width: 2, color: UIColor.white)*/
        
        
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
    @objc public  func DismissKeyboard(){
        view.endEditing(true)
    }
}

