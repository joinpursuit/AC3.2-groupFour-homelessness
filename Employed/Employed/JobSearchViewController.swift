//
//  JobSearchViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SCLAlertView

class JobSearchViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
    var animator = UIViewPropertyAnimator(duration: 1.0, dampingRatio: 0.5, animations: nil)
    let array = [["", "Technology","Healthcare","Informational","Hospitality"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !launchedBefore  {
            firstLaunchAlert()
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        searchJobTextField.isHidden = true
        picker.isHidden = true
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
        self.view.addSubview(picker)
        
        picker.delegate = self
        
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
        
        findJobButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(greetingLabel.snp.bottom).offset(8.0)
        }
        
        searchIcon.snp.makeConstraints { (view) in
            view.trailing.equalTo(searchJobTextField.snp.leading).offset(-10)
        }
        
        searchButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview().offset(40.0)
        }
        
        findJobButton.addTarget(self, action: #selector(letsGetStartedClicked), for: .touchUpInside)
    }
    
    func firstLaunchAlert() {
        
        let appearance = SCLAlertView.SCLAppearance(
            kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
            kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
            kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
            showCloseButton: true
        )
        
        let alertView = SCLAlertView(appearance: appearance)
        let alertViewIcon = UIImage(named: "logo") //Replace the IconImage text with the image name
        alertView.showInfo("Welcome to Employed", subTitle: "The Central Job Hub center, where you can find the latest jobs. Click 'Lets Go' to Begin", circleIconImage: alertViewIcon)
        
    }
    
    //MARK: - Picker Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array[component].count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView,didSelectRow row: Int, inComponent component: Int){
        updateLabel()
    }
    
    func updateLabel(){
        
        _ = array[0][picker.selectedRow(inComponent: 0)]
    }

    //MARK: - TextField Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchJobTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchJobs()
        textField.resignFirstResponder()
        return true
    }
    
    
    func letsGetStartedClicked(){
        findJobButton.isHidden = true
        searchJobTextField.isHidden = false
        searchButton.isHidden = false
        picker.isHidden = false
        
        searchButton.addTarget(self, action: #selector(searchJobs), for: .touchUpInside)
  
        findJobButton.removeFromSuperview()
        
        greetingLabel.snp.remakeConstraints { (view) in
            
            view.centerX.equalToSuperview()
            view.bottom.equalTo(picker.snp.top).offset(-5)
        }
        
        picker.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.9)
            view.height.lessThanOrEqualToSuperview().multipliedBy(0.25)
            view.bottom.equalTo(searchJobTextField.snp.top).offset(-10)
        }
        
        searchJobTextField.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.centerY.equalToSuperview()//.multipliedBy(0.9)
            //view.bottom.equalTo(searchButton.snp.top).offset(-5)
        }
        
        searchButton.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(searchJobTextField.snp.bottom)
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
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .white
        picker.alpha = 0.6
        
        return picker
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        let backgroundImage = UIImage(named: "backgroundPic")
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let backgroundImageTopLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
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
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 30.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .white
        label.text = "What Job are you looking for?"
        label.numberOfLines = 0
        
        label.textAlignment = .center
        return label
    }()
    
    private let findJobButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Let's Get Started", for: .normal)
        button.setTitleColor(Colors.backgroundColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: 5.0)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Search", for: .normal)
        button.setTitleColor(Colors.backgroundColor, for: .normal)
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

