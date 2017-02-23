//
//  EditProfileTableViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/20/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseDatabase
import MobileCoreServices

protocol ProfileStateDelegate: class{
    var infoUpdated: Bool {get set}
    var pictureUpdated: Bool {get set}
    func changeProfileImage(to image:UIImage)
}
class EditProfileTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{
    
    private let cellInfo: [(title:String,placeholder:String)] = [("First Name", "First Name"),("Last Name","Last Name"),("Email","Email Address"),("Phone Number","555-555-5555"),("Work Experience",""),("Education",""),("Skills","")]
    private var userInfoDic = ["FirstName":"","LastName":"","Email":"","Phone":"","Experience":"","Education":"","Skills":""]
    private var dicFields: [String] = ["FirstName","LastName","Email","Phone","Experience","Education","Skills"]
    private let tableView: UITableView = UITableView()
    
    private let dataBaseReference = FIRDatabase.database().reference()
    var profileImage: UIImage?
    private var selectedImage: UIImage?
    var textValues: [String] = []
    weak var profileUpdatedDeleate: ProfileStateDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(dismissme))
        
        self.title = "Edit Profile"
        
        setUpViews()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getProfileInfo()
    }
    
    //MARK: Utilties
    func setUpViews(){
        
        self.view.addSubview(tableView)
        self.view.addSubview(applyChangesButton)
        
        tableView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        applyChangesButton.snp.makeConstraints { (view) in
            view.trailing.leading.bottom.equalToSuperview()
            view.height.equalTo(50)
            
        }
        
        applyChangesButton.addTarget(self, action: #selector(upDateProfile), for: .touchUpInside)
    }
    
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EditInfoWithTextFieldTableViewCell.self, forCellReuseIdentifier: EditInfoWithTextFieldTableViewCell.cellIdentifier)
        tableView.register(EditInfoProfileImageTableViewCell.self, forCellReuseIdentifier: EditInfoProfileImageTableViewCell.cellIdentifier)
        tableView.register(EditInfoWithTextViewTableViewCell.self, forCellReuseIdentifier: EditInfoWithTextViewTableViewCell.cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        tableView.sectionFooterHeight = UITableViewAutomaticDimension
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    func dismissme(){
        dismiss(animated: true, completion: nil)
    }
    
    func upDateProfile(){
        let databaseRef = FIRDatabase.database().reference().child("UserInfo")
        let childRef = databaseRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        childRef.updateChildValues(userInfoDic) { (error, ref) in
            if error != nil{
                print("\(error?.localizedDescription)")
            }else{
                print("Profile Updated")
                self.dismissme()
            }
        }
        
        if let image = selectedImage{
            self.profileUpdatedDeleate?.changeProfileImage(to: image)
        }
    }
    
    private func showImagePicker(){
        
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [String(kUTTypeImage)]
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    private func getProfileInfo(){
        if FIRAuth.auth()?.currentUser != nil{
            
            let databaseRef = FIRDatabase.database().reference().child("UserInfo")
            let childRef = databaseRef.child((FIRAuth.auth()?.currentUser?.uid)!)
            
            childRef.observe(.value, with: { (snapshot) in
                
                if let userDic = snapshot.value as? [String:String]{
                    print(userDic)
                    self.userInfoDic = userDic
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellInfo.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        
        switch row{
            
        case _ where row == 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoProfileImageTableViewCell.cellIdentifier, for: indexPath) as! EditInfoProfileImageTableViewCell
        
            if selectedImage != nil{
                cell.profileImage.image = selectedImage
            }else{
                cell.profileImage.image = profileImage
            }
            
            return cell
        case _ where row > 4:
            
            let info = cellInfo[row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoWithTextViewTableViewCell.cellIdentifier, for: indexPath) as! EditInfoWithTextViewTableViewCell
            cell.cellTitle.text = info.title
            cell.cellTextView.tag = row - 1
            cell.cellTextView.delegate = self
            
            if let info = userInfoDic[dicFields[row - 1]]{
                cell.cellTextView.text = info
            }
            return cell
            
        default:
            let info = cellInfo[row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoWithTextFieldTableViewCell.cellIdentifier, for: indexPath) as! EditInfoWithTextFieldTableViewCell
            
            cell.cellTitle.text = info.title
            cell.cellTextField.tag = row - 1
            cell.cellTextField.placeholder = info.placeholder
            cell.cellTextField.delegate = self
            cell.cellTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            if let info = userInfoDic[dicFields[row - 1]]{
                cell.cellTextField.text = info
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            showImagePicker()
        }
    }
    
    //MARK: ImagePicker Delegate
    //MARK: - TO DO
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.selectedImage = image
            self.tableView.reloadData()
            dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: Textfield Delegates
    
    func textFieldDidChange(_ textField: UITextField) {
        let field = dicFields[textField.tag]
        userInfoDic[field] = textField.text
        self.profileUpdatedDeleate?.infoUpdated = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let field = dicFields[textView.tag]
        userInfoDic[field] = textView.text
        self.profileUpdatedDeleate?.infoUpdated = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private let applyChangesButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("Apply Changes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.accentColor
        return button
    }()
    
}
