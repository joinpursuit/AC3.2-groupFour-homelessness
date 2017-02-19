//
//  SearchDetailViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class SearchDetailViewController: UIViewController, UINavigationControllerDelegate, UINavigationBarDelegate {
    var jobPost: NYCJobs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        self.title = jobPost.buisnessTitle
        self.view.backgroundColor = Colors.primaryColorUIColor
        
        let barButton = UIBarButtonItem(customView: saveButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        //Job Detail profile
        self.jobTitle.text = jobPost.buisnessTitle
        self.agencyLabel.text = jobPost.agency
        self.addressLabel.text = jobPost.workLocation
        self.jobPostDescription.text = jobPost.jobDescription
        
    }
    
    
    //MARK: - SetupViews
    func setUpViews(){
        self.view.addSubview(jobTitle)
        self.view.addSubview(agencyLabel)
        self.view.addSubview(addressLabel)
        self.view.addSubview(jobPostDescription)
        
        self.edgesForExtendedLayout = []
     
        jobTitle.snp.makeConstraints { (view) in
            view.top.equalToSuperview()
            view.leading.equalToSuperview()
        }
        
        agencyLabel.snp.makeConstraints { (view) in
            view.top.equalTo(jobTitle.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        addressLabel.snp.makeConstraints { (view) in
            view.top.equalTo(agencyLabel.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        jobPostDescription.snp.makeConstraints { (view) in
            view.top.equalTo(addressLabel.snp.bottom).offset(16.0)
            view.centerX.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.5)
            view.width.equalToSuperview().offset(8.0)
        }
    }

    //MARK: - Utilities
    func savePost() {
        
        let alert = UIAlertController(title: "Saved job post!", message: "This is now in your saved list.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Views
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(savePost), for: .touchUpInside)
        button.setTitle("save", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        
        return button
    }()
    
    private lazy var jobTitle: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var agencyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    private lazy var jobPostDescription: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    
    
    
    
}
