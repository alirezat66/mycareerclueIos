//
//  AddCollectionStepTwo.swift
//  WeYouMaster
//
//  Created by alireza on 11/14/18.
//  Copyright © 2018 alireza. All rights reserved.
//

import UIKit
import Dropper
import SearchTextField
import SwiftMessages
import DropDown

class AddChapterVC: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate,UITextViewDelegate  {
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var labelCollectionView: UICollectionView!
    var strSelectedSkill = String()

    let dropDown = DropDown()
    @IBOutlet weak var skillSearchTextField: SearchTextField!
    @IBOutlet weak var dropdown : UIButton!
    
    @IBOutlet weak var picTwo: UIImageView!
    @IBOutlet weak var backOne: UIView!
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    var Profile_photo_link : String = ""
    var Owner: String = ""
    var publicType  = 1
    var rtl = 1
    var step = 1
    var type  = 0
    var count = 1
    var chosenImage = false
    var lastCurrency : String = ""
    var chapterId : String  = ""
    var imageData: Data? = nil
    var activeColor = UIColor.init(red: 73.0/255.0, green: 2/255.0, blue: 78/255.0, alpha: 1.0)
    
    var collectionId = "0"
    var isOpen = false
    var isOpenCat = false
    var skilList=[""]
    var collectionList = [""]
     var myCollection : [CollectionOther] = []
    var skilType = [""]
    var myLabeles : [LabelPrototype] = []
    var addedLabeles : [LabelPrototype] = []
   
    
    
    
    
    @IBAction func publicToggleChange(_ sender: Any) {
        if publicSwitch.isOn {
            publicType = 1
            lblPublic.text = "public"
        }
        else
        {
            publicType = 0
            lblPublic.text = "private"
            
        }
    }
    @IBAction func rtlToggleChange(_ sender: Any) {
        if rtlSwitch.isOn {
            rtl = 1
            lblRtl.text = "ltr"
        }
        else
        {
            lblRtl.text = "rtl"
            rtl = 0
        }
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
      //  getLabeles()
        getCloolections()
        
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
        // Do any additional setup after loading the view.
    }
    
    @IBAction func imgBackAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if edtDesc.textColor == UIColor.lightGray {
            edtDesc.text = ""
            edtDesc.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if edtDesc.text.isEmpty {
            edtDesc.text = "Describe Your Chapter"
            edtDesc.textColor = UIColor.lightGray
        }
    }
    
    func getCloolections(){
        loadingView.isHidden = false
        let userDefaults = UserDefaults.standard
        let owner = userDefaults.value(forKey: "owner") as! String
        WebCaller.getCollectionOther(20,1,owner: owner,userId: owner) { (collections , error) in
            if let error = error{
                print(error)
                return
            }
            guard let collections = collections else{
                print("error getting collections")
                return
            }
            if(self.myCollection.count>0){
            self.myCollection.remove(at: 0)
            
            }
            self.collectionList.remove(at: 0)
            for collect in collections.records{
                self.collectionList.append(collect.Collection_Title)
                self.myCollection.append(collect)
            }
            self.updateUIForCollection()
        }
    }
    func updateUIForCollection(){
        // first we add dropper
        dropDown.dataSource = collectionList
        DispatchQueue.main.async{
            self.loadingView.isHidden = true
            //self.alertController.dismiss(animated: true, completion: nil);
            
        }
        
        // second we add search list
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
            if(text != "Select Category"){
                let labbel = LabelPrototype(type: text ?? "", title: skillSearchTextField.text ?? "")
                skillSearchTextField.text = ""
                skilbutton.setTitle("Select Category", for: .normal)
                
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
       
        //  present(self.imagePicker, animated: true, completion: nil)
        
        
    }
    @IBAction func btnChose(_ sender: Any) {
        dropDown.dataSource = collectionList
        dropDown.selectionAction = {[unowned self ] (index: Int, item : String) in
            self.dropdown.setTitle(item, for: .normal)
            self.dropDown.hide()
            self.edtDesc.delegate = self
            self.collectionId = self.myCollection[index].collectionId

            
        }
        dropDown.customCellConfiguration = {(index, item, cell:DropDownCell) ->Void in cell.optionLabel.textAlignment = .center}
        dropDown.width = 300
        dropDown.show()
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
    
    
    func updateUI(){
        
        
        DispatchQueue.main.async{
            // first we add dropper
            
            self.dropDown.anchorView = self.skilbutton
            self.dropDown.dataSource = self.skilType
            self.dropDown.cornerRadius = 10
            self.makeSearchList()
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
            addChapter()
            //addCollection()
            
        }else if count==2{
            if(chosenImage){
                
                //upload()
                stepThree()
            }else{
                stepThree()
            }
        }else if(count == 3){
            addLabeles()
        }
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
    func addChapter() {
        
        if(self.edtTitle.text != ""){
            
            loadingView.isHidden = false
            let userDefaults = UserDefaults.standard
            let owner = userDefaults.value(forKey: "owner") as! String
            WebCaller.saveChapter(owner: owner,collectionId: collectionId, title: self.edtTitle.text!, description: self.edtDesc.text!, isPublic: publicType, isRtl: rtl, link: "")
            { (answer, error) in
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
                    
                    self.chapterId = answer.chapterId
                    self.stepThree()
                }else{
                    self.showError()
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
            self.count = 2
        }
    }
    func stepThree()  {
        DispatchQueue.main.async{
            
            //self.alertController.dismiss(animated: true, completion: nil);
           
            self.lblPublic.text  = "step two" + String(self.count)
            self.viewStepOne.isHidden = true
            self.viewStepTwo.isHidden = true
            self.UIViewThree.isHidden = false
            self.backThree.backgroundColor = self.activeColor
            self.count = 3
            self.getLabeles()
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
            
            WebCaller.addLabelChapter(owner, chapterId, finalLabel){
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
        view.configureContent(title: "Alert", body: "It is accurating some problem, please try again", iconText: iconText)
        view.iconImageView?.isHidden = true
        view.button?.isHidden = true
        view.semanticContentAttribute = .forceRightToLeft
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        
        // Show the message.
   
        SwiftMessages.show(view: view)
            

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
