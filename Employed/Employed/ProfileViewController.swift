//
//  ProfileViewController.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import Photos
import MobileCoreServices


class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ProfileStateDelegate{
    private lazy var imagePickerController: UIImagePickerController = UIImagePickerController()
    private var userDic: [String:String] = [:]
    
    private let dataBaseReference = FIRDatabase.database().reference()
    
    var infoUpdated: Bool = true
    var pictureUpdated: Bool = true
    
    //Can be used to populate profile tableview
    private let infoImageArray: [String] = ["user","heart","suitcase","resume"]
    private var infoDetails: [(title:String,description:String)] = [("About Me","I love food"),("Some stuff","I like that too"), ("Blah blah", "Blah di blah blah"),("R\u{E9}sum\u{E9}","Click to Add/Update R\u{E9}sum\u{E9}")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(customView: logOutButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        
        setUpViews()
        setUpTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if infoUpdated{
            getProfileInfo()
            infoUpdated = false
        }
        
        if pictureUpdated{
            getProfilePicture()
            pictureUpdated = false
        }
    }
    
    func setUpViews(){
        self.view.addSubview(profileBackGround)
        self.view.addSubview(nameLabel)
        self.view.addSubview(infoTableView)
        self.view.addSubview(profilePic)
        self.view.addSubview(editProfileButton)
        
        self.edgesForExtendedLayout = []
        
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        profileBackGround.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.4)
        }
        
        profilePic.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(20)
            view.centerX.equalToSuperview()
            view.size.equalTo(CGSize(width: 150, height: 150))
        }
        editProfileButton.snp.makeConstraints { (view) in
            view.centerY.equalTo(profileBackGround.snp.bottom)
            view.trailing.equalToSuperview().inset(30)
            view.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        nameLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(profilePic.snp.bottom).offset(15)
            
        }
        
        addResume.addTarget(self, action: #selector(showCamera), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        
        infoTableView.snp.makeConstraints { (view) in
            view.top.equalTo(profileBackGround.snp.bottom)
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func showCamera(){
        showImagePickerfor(source: .camera)
    }
    
    private func getProfileInfo(){
        if FIRAuth.auth()?.currentUser != nil{
            
            let databaseRef = FIRDatabase.database().reference().child("UserInfo")
            let childRef = databaseRef.child((FIRAuth.auth()?.currentUser?.uid)!)
            
            
            
            childRef.observe(.value, with: { (snapshot) in
                
                if let userDic = snapshot.value as? [String:String]{
                    self.userDic = userDic
                    self.updateProfileInfo()
                }else{
                    self.nameLabel.text = FIRAuth.auth()?.currentUser?.email
                }
            })
        }
    }
    
    private func getProfilePicture(){
        let storageRef = FIRStorage.storage().reference(forURL: "gs://employed-42a2b.appspot.com").child("ProfileImage")
        let imageRef = storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        imageRef.data(withMaxSize: 1 * 1024 * 1024, completion: { (data, error) in
            if error != nil{
                print("\(error?.localizedDescription)")
            }else{
                if let image = UIImage(data: data!){
                    self.changeProfileImage(to: image)
                    
                }
            }
        })
    }
    
    private func updateProfilePic(image: UIImage){
        let storageRef = FIRStorage.storage().reference(forURL: "gs://employed-42a2b.appspot.com").child("ProfileImage")
        let imageRef = storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else { return }
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(imageData, metadata: metaData) { (_, error) in
            if error != nil{
                print("\(error?.localizedDescription)")
            }else{
                print("Profile pic updated")
            }
        }
    }
    
    private func updateProfileInfo(){
        self.nameLabel.text = ("\(userDic["FirstName"] ?? "Update Profile") \(userDic["LastName"] ?? "")")
    }
    
    func setUpTableView(){
        self.infoTableView.delegate = self
        self.infoTableView.dataSource = self
        self.infoTableView.rowHeight = UITableViewAutomaticDimension
        self.infoTableView.estimatedRowHeight = 200
        infoTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.cellIdentifier)
    }
    
    //MARK:- Utilities
    
    func logOut() {
        do{
            try FIRAuth.auth()?.signOut()
        }
        catch{
            let alertController = UIAlertController(title: "Error", message: "Trouble Logging Out", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func handleTap() {
        showImagePickerfor(source: .photoLibrary)
    }
    
    func editProfile(){
        let editProfVC = EditProfileTableViewController()
        editProfVC.profileImage = self.profilePic.image
        editProfVC.profileUpdatedDeleate = self
        let editProfNVC = UINavigationController(rootViewController: editProfVC)
        self.navigationController?.present(editProfNVC, animated: true, completion: nil)
    }
    
    private func showImagePickerfor(source: UIImagePickerControllerSourceType){
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        
        switch source{
        case .camera:
            imagePicker.sourceType = .camera
            let overlay = CameraOverlayView()
            overlay.frame = CGRect(x: 0, y: 0, width: 420, height: 595)
            overlay.center = self.view.center
            imagePicker.cameraOverlayView = overlay
            imagePicker.modalPresentationStyle = .currentContext
        case .photoLibrary:
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = [String(kUTTypeImage)]
        default:
            break
        }
        
        imagePickerController = imagePicker
        self.tabBarController?.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: -ImagePicker delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let imageFromPicker = info["UIImagePickerControllerOriginalImage"] as? UIImage else { return }
        
        switch imagePickerController.sourceType{
        case .camera:
            dismiss(animated: true, completion: nil)
            if let imageData = EmployedFileManager.shared.convertToPDf(image: imageFromPicker){
                EmployedFileManager.shared.saveFile(data: imageData)
                if let pdfUrl = EmployedFileManager.shared.retreivePDF(){
                    let resumeVC = ResumePreviewViewController()
                    resumeVC.pdfUrl = URLRequest(url: pdfUrl)
                    present(resumeVC, animated: true, completion: nil)
                }
            }
        case .photoLibrary:
            changeProfileImage(to: imageFromPicker)
            updateProfilePic(image: imageFromPicker)
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK :- TableView degelgate methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.cellIdentifier, for: indexPath) as! InfoTableViewCell
        let info = infoDetails[indexPath.row]
        
        cell.cellTitle.text = info.title
        cell.cellDetail.text = info.description
        cell.cellIcon.image = UIImage(named: infoImageArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == infoDetails.count - 1{
            
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                showImagePickerfor(source: .camera)
            }else{
                print("No camera available")
            }
            
        }else{
            
            let profVC = ProfileDetailViewController()
            let info = infoDetails[indexPath.row]
            
            profVC.controllerTitle.text = info.title
            profVC.controllerDetail.text = info.description
            self.navigationController?.pushViewController(profVC, animated: true)
        }
    }
    
    //MARK: Profile Change Delegate
    
    func changeProfileImage(to image: UIImage) {
        UIView.animate(withDuration: 1) {
       // self.profilePic.alpha = 0
            self.profileBackGround.alpha = 0
        }
        self.profilePic.image = image
        self.profileBackGround.image = image
        
        UIView.animate(withDuration: 3) {
//            self.profilePic.alpha = 1
            self.profileBackGround.alpha = 1
        }
        
    }
    
    //MARK: - Views
    private lazy var profilePic: UIImageView = {
        let imageView = UIImageView()
        
        imageView.layer.cornerRadius = 75
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.4
        imageView.layer.shadowOffset = CGSize(width: 1, height: 5)
        imageView.layer.shadowRadius = 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "onepunch")
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tap.delaysTouchesBegan = true
        tap.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    private let infoTableView: UITableView = {
        let tableview: UITableView = UITableView()
        tableview.backgroundColor = .white
        return tableview
    }()
    
    private let addResume: UIButton = {
        let button: UIButton = UIButton(type: UIButtonType.system)
        button.setTitle("Add Resume", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private let profileBackGround: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.backgroundColor = .lightGray
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "One Punch"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setImage(UIImage(named: "logout"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        return button
    }()
    
    private let editProfileButton: UIButton = {
        let button: UIButton = UIButton()
        button.setImage(UIImage(named: "pencil"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.snp.makeConstraints({ (view) in
            view.size.equalTo(CGSize(width: 30, height: 30))
        })
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.layer.shadowRadius = 2
        button.backgroundColor = Colors.lightPrimaryColor
        button.layer.cornerRadius = 25
        return button
    }()
    
}
