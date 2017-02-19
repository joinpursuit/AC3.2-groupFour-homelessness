//
//  JobSearchViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class JobSearchViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.lightPrimaryColor
        setUpViews()
    }
    
    //MARK:- SetupViews
    func setUpViews(){
        
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(greetingLabel)
        self.view.addSubview(findJobButton)
        
        
        greetingLabel.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
        }
        
        findJobButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(greetingLabel.snp.bottom).offset(8.0)
            
        }
        
        findJobButton.addTarget(self, action: #selector(searchJobs), for: .touchUpInside)
    }
    
    //MARK: - Utilities
    
    func searchJobs() {
        
        let searchResultsVC = SearchResultsTableViewController()
        navigationController?.pushViewController(searchResultsVC, animated: true)
        
    }
    
    
    //MARK: - Views
    private let searchJobTextField: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.placeholder = "What job do you want?.."
        textfield.backgroundColor = Colors.lightPrimaryColor
        return textfield
    }()
    
    private let greetingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "I'm looking for"
        return label
    }()
    
    private let findJobButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("a job", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
}
