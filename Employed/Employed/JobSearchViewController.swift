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
        
        self.view.backgroundColor = Colors.backgroundColor
        
        setUpViews()
    }
    
    
    //MARK:- SetupViews
    func setUpViews(){
        
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(backgroundImage)
        self.backgroundImage.addSubview(backgroundImageTopLayer)
        self.view.addSubview(findJobButton)
        self.view.addSubview(greetingLabel)
        self.view.addSubview(searchJobTextField)
    
        
        
        backgroundImage.snp.makeConstraints { (view) in
            view.top.equalToSuperview()
            view.bottom.equalToSuperview()
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.height.equalToSuperview()
            view.width.equalToSuperview()
        }
        
        backgroundImageTopLayer.snp.makeConstraints { (view) in
            view.top.leading.trailing.bottom.equalToSuperview()
            view.height.width.equalToSuperview()
        }
        
        greetingLabel.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
        }
        
        searchJobTextField.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.top.equalTo(greetingLabel.snp.bottom).offset(8.0)
            view.width.equalToSuperview().multipliedBy(0.5)
        }
        
        
        findJobButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(searchJobTextField.snp.bottom).offset(8.0)
        }
        
        findJobButton.addTarget(self, action: #selector(searchJobs), for: .touchUpInside)
    }
    
    //MARK: - Utilities
    
    func searchJobs() {
        print("pressed search")
        let searchResultsVC = SearchResultsTableViewController()
        navigationController?.pushViewController(searchResultsVC, animated: true)
    }
    
    
    //MARK: - Views
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        let backgroundImage = UIImage(named: "backgroundPic")
        image.image = backgroundImage
        image.tintColor = .orange
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let backgroundImageTopLayer: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.backgroundColor
        view.alpha = 0.6
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let searchJobTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.placeholder = "_________"
        return textField
    }()
    
    private let greetingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .white
        label.text = "I'm looking to.."
        return label
    }()
    
    private let findJobButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("find", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: 5.0)
        return button
    }()
    
}
