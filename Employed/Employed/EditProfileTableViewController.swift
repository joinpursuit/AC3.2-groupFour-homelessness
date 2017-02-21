//
//  EditProfileTableViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/20/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class EditProfileTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate{
    private let cellInfo: [(title:String,placeholder:String)] = [("First Name", "First Name"),("Last Name","Last Name"),("Email","Email Address"),("Phone Number","555-555-5555"),("Work Experience",""),("Education",""),("Skills","")]
    private let tableView: UITableView = UITableView()
    var profileImage: UIImage?
    var textValues: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(dismissme))
        
        self.title = "Edit Profile"
        
        setUpViews()
        setupTableView()
    }
    
    //MARK: Utilties
    func setUpViews(){
        
        self.view.addSubview(tableView)
        self.view.addSubview(applyChangesButton)
        
        tableView.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        applyChangesButton.snp.makeConstraints { (view) in
            view.centerX.bottom.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.7)
        }
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
        tableView.estimatedSectionFooterHeight = 50
        tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15)
    }
    
    func dismissme(){
        dismiss(animated: true, completion: nil)
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
            cell.profileImage.image = profileImage
            return cell
        case _ where row > 4:
            
            let info = cellInfo[row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoWithTextViewTableViewCell.cellIdentifier, for: indexPath) as! EditInfoWithTextViewTableViewCell
            cell.cellTitle.text = info.title
            cell.cellTextView.delegate = self
            return cell
            
        default:
            
            let info = cellInfo[row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: EditInfoWithTextFieldTableViewCell.cellIdentifier, for: indexPath) as! EditInfoWithTextFieldTableViewCell
            
            cell.cellTitle.text = info.title
            cell.cellTextField.tag = indexPath.row
            cell.cellTextField.placeholder = info.placeholder
            cell.cellTextField.delegate = self
            return cell
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Textfield\(textField.tag) finished with \(textField.text ?? "Nothing")")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private let applyChangesButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("Apply Changes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.darkPrimaryColor
        return button
    }()
    
}
