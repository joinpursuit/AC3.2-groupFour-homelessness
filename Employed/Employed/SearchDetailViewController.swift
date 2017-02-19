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
        self.jobPostDescription.text = jobPost.civilTitle
        
    }
    
    
    //MARK: - SetupViews
    func setUpViews(){
        self.view.addSubview(jobPostDescription)
        
        self.edgesForExtendedLayout = []
     
        jobPostDescription.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.centerX.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.4)
        }
    }

    //MARK: - Utilities
    func savePost() {
        print("save post")
    }
    
    //MARK: - Views
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(savePost), for: .touchUpInside)
        button.setTitle("save", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        
        return button
    }()
    
    private lazy var jobPostDescription: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    
    
    
    
    
}
