//
//  ViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var databaseReference = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observeKeyboardNotifications()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setUpViews()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if FIRAuth.auth()?.currentUser != nil {
            self.navigationController?.pushViewController(ProfileViewController(), animated: false)
        } else {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    //MARK:- SetupViews
    func setUpViews(){
        
        self.edgesForExtendedLayout = []
        
        let padding: CGFloat = 10
        
        self.view.addSubview(backgroundImage)
        self.backgroundImage.addSubview(backgroundImageTopLayer)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(loginLogo)
        self.view.addSubview(appLabel)
        
        backgroundImage.snp.makeConstraints { (view) in
            
            view.top.leading.trailing.bottom.equalToSuperview()
            
        }
        
        backgroundImageTopLayer.snp.makeConstraints { (view) in
            view.top.leading.trailing.bottom.equalToSuperview()
            
        }
        
        appLabel.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(24)
            view.centerX.equalToSuperview()
        }
        
        loginLogo.snp.makeConstraints { (view) in
            view.top.equalTo(appLabel.snp.bottom).offset(8)
            view.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { (view) in
            view.top.equalTo(appLabel.snp.bottom).offset(8.0)
            view.center.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.9)
            view.height.equalToSuperview().multipliedBy(0.1)
        }
        
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(self.emailTextField.snp.bottom).offset(padding)
            view.centerX.equalToSuperview()
            view.size.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { (view) in
            view.top.equalTo(passwordTextField.snp.bottom).offset(padding)
            view.centerX.equalToSuperview()
            view.size.equalTo(emailTextField)
        }
        
        registerButton.snp.makeConstraints { (view) in
            view.top.equalTo(loginButton.snp.bottom).offset(10.0)
            view.centerX.equalToSuperview()
            view.size.equalTo(emailTextField)
        }
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    
    //MARK: - Utilities
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    fileprivate func observeKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: .UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard), name: .UIKeyboardDidHide, object: nil)
    }
    
    func showKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -50, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func hideKeyboard() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func login() {
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                
                if user != nil {
                    
                    if let tabVC =  self.navigationController {
                        tabVC.show(ProfileViewController(), sender: nil)
                        
                    }
                } else {
                    
                    self.showAlertFailure(title: "Login Failed!", error: error!)
                }
                
            })
        }
        
    }
    
    func register() {
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user:FIRUser?, error: Error?) in
                
                if error != nil {
                    self.showAlertFailure(title: "Register Failed!", error: error!)
                }
                
                
                if let tabVC =  self.navigationController {
                    tabVC.show(ProfileViewController(), sender: nil)
                }
            })
        }
    }
    
    func showAlertFailure(title: String, error: Error) {
        let alertController = UIAlertController(title: title, message: "\(error.localizedDescription)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: - Views
    private let appLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 40.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .white
        label.text = "Employed"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        let backgroundImage = UIImage(named: "office")
        image.image = backgroundImage
        
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let backgroundImageTopLayer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.alpha = 0.8
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private let loginLogo: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "logoYello")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailTextField: LeftPaddedText = {
        let textfield = LeftPaddedText()
        textfield.backgroundColor = .black
        textfield.attributedPlaceholder = NSAttributedString(string: "Email..", attributes: [NSForegroundColorAttributeName: Colors.lightPrimaryColor])
        textfield.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "user2")
        imageView.image = image
        textfield.leftView = imageView
        
        textfield.alpha = 0.5
        textfield.textColor = .white
        textfield.keyboardType = .emailAddress
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    private let passwordTextField: LeftPaddedText = {
        let textfield = LeftPaddedText()
        textfield.backgroundColor = .black
        textfield.attributedPlaceholder = NSAttributedString(string: "Password..", attributes: [NSForegroundColorAttributeName: Colors.lightPrimaryColor])
        textfield.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "password")
        imageView.image = image
        textfield.leftView = imageView
        
        textfield.alpha = 0.5
        textfield.textColor = .white
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    private let loginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("LOGIN", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor =  Colors.darkPrimaryColor
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        
        return button
    }()
    
    private let registerButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.lightPrimaryColor
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 20)
        return button
        
    }()
    
}

class LeftPaddedText: UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 22, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 22, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}

