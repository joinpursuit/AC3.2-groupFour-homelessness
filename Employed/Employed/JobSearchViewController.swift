//
//  JobSearchViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class JobSearchViewController: UIViewController, UITextFieldDelegate {
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
     var animator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.5, animations: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if launchedBefore  {
            print("Not first launch.")
        } else {
            firstLaunchAlert()
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        searchJobTextField.isHidden = true
        searchIcon.isHidden = true
        searchButton.isHidden = true
        searchJobTextField.delegate = self
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
        self.view.addSubview(searchIcon)
        self.view.addSubview(searchButton)
        
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
            view.center.equalToSuperview()
        }
        
        searchJobTextField.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(findJobButton.snp.top).offset(-10)
        }
        
        
        findJobButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(greetingLabel.snp.bottom).offset(8.0)
        }
        
        searchIcon.snp.makeConstraints { (view) in
            view.trailing.equalTo(searchJobTextField.snp.leading).offset(-10)
        }
        
        
        findJobButton.addTarget(self, action: #selector(letsGetStartedClicked), for: .touchUpInside)
        
        searchButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.center.equalToSuperview().offset(40.0)
        }
        
        
    }
    
    func firstLaunchAlert() {
        let alertController = UIAlertController(title: "Nice to have you!", message: "Welcome to Employed! The Central Job Hub center, where you can find all the latest jobs. Click Lets Go to Contiune", preferredStyle: .actionSheet)
        let letsGo = UIAlertAction(title: "Lets Go", style: .default, handler: nil)
        alertController.addAction(letsGo)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - TextField Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchJobTextField.resignFirstResponder()
    }
    
    
    func letsGetStartedClicked(){
        findJobButton.isHidden = true
        searchJobTextField.isHidden = false
        searchButton.isHidden = false
        
        searchButton.addTarget(self, action: #selector(searchJobs), for: .touchUpInside)
//        findJobButton.snp.remakeConstraints { (view) in
//            view.centerX.equalToSuperview()
//            view.center.equalToSuperview().offset(40.0)
//        }
        
        searchButton.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.center.equalToSuperview().offset(40.0)
        }
        
        greetingLabel.snp.remakeConstraints { (view) in
            view.trailing.leading.equalToSuperview()
            view.center.equalToSuperview().offset(-20)
        }
        
        searchJobTextField.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalTo(searchButton.snp.top).offset(-5)
        }
        
        searchIcon.snp.remakeConstraints { (view) in
            view.trailing.equalTo(searchJobTextField.snp.leading).offset(-10)
        }
        
        animator.addAnimations {
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
        
    
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
        view.alpha = 0.5
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let searchJobTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        let myString = "Enter job here"
        let myAttribute = [ NSForegroundColorAttributeName: Colors.dividerColor ]
        let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
        
        textField.attributedPlaceholder = myAttrString
        textField.alpha = 0.8
        return textField
    }()
    
    private let greetingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .white
        label.text = "What Job are you looking for?"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let findJobButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Lets Get Started", for: .normal)
        button.setTitleColor(Colors.darkPrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: 5.0)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(Colors.darkPrimaryColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: 5.0)
        return button
    }()
    
    private let searchIcon: UIImageView = {
        var image = UIImageView()
         let backgroundImage = UIImage(named: "search")
        image.image = backgroundImage
        return image
    }()
    
}
