//
//  ProfileViewController.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import Photos
import MobileCoreServices


class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
    private lazy var imagePickerController: UIImagePickerController = UIImagePickerController()
    
    //Can be used to populate profile tableview
    private let infoImageArray: [UIImage] = []
    private let infoDetails: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem(customView: logOutButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.hidesBackButton = true
        self.view.backgroundColor = .white
        setUpViews()
        setUpTableView()
        //setImagePicker()
    }
    
    func setUpViews(){
        self.view.addSubview(profileBackGround)
        self.profileBackGround.addSubview(addResume)
        self.profileBackGround.addSubview(nameLabel)
        self.view.addSubview(infoTableView)
        self.profileBackGround.addSubview(profilePic)
        
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
        
        nameLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(profilePic.snp.bottom).offset(15)
            
        }
        
        addResume.addTarget(self, action: #selector(showCamera), for: .touchUpInside)
        
        infoTableView.snp.makeConstraints { (view) in
            view.top.equalTo(profileBackGround.snp.bottom)
            view.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func showCamera(){
        showImagePickerfor(source: .camera)
        // present(imagePickerController, animated: true, completion: nil)
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
    
    private func showImagePickerfor(source: UIImagePickerControllerSourceType){
        let imagePicker: UIImagePickerController = UIImagePickerController()
        imagePicker.delegate = self
        
        switch source{
        case .camera:
            imagePicker.sourceType = .camera
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
            profilePic.image = imageFromPicker
            profileBackGround.image = imageFromPicker
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.cellIdentifier, for: indexPath) as! InfoTableViewCell
        
        return cell
    }
    
    //MARK: - Views
    
    internal lazy var profilePic: UIImageView = {
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
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }()
    
    
    internal let infoTableView: UITableView = {
        let tableview: UITableView = UITableView()
        tableview.backgroundColor = .red
        return tableview
    }()
    
    internal let addResume: UIButton = {
        let button: UIButton = UIButton(type: UIButtonType.system)
        button.setTitle("Add Resume", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    internal let profileBackGround: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "onepunch")
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    internal let nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "One Punch"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    internal lazy var logOutButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.setTitle("LogOut", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        return button
    }()
    
    
}
