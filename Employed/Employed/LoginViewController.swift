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
    

    let newViewController = ProfileViewController()
    var databaseReference = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem.title = "LOGIN/REGISTER"

        setUpViews()

        if FIRAuth.auth()?.currentUser != nil {
            self.navigationController?.pushViewController(newViewController, animated: false)
        } else {
                self.navigationController?.navigationBar.isHidden = true
        }
    }
    
    //MARK:- SetupViews
    func setUpViews(){
        
        self.edgesForExtendedLayout = []
        
        let padding: CGFloat = 30
        
        self.view.addSubview(backgroundImage)
        self.backgroundImage.addSubview(backgroundImageTopLayer)
        self.view.addSubview(loginLogo)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        //self.view.addSubview(registerLabel)
        self.view.addSubview(registerButton)
        
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
        
        loginLogo.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().offset(padding)
        }
        
        emailTextField.snp.makeConstraints { (view) in
            view.center.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.7)
            view.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(self.emailTextField.snp.bottom).offset(padding)
            view.centerX.equalToSuperview()
            view.size.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { (view) in
            view.top.equalTo(self.passwordTextField.snp.bottom).offset(padding)
            view.centerX.equalToSuperview()
            view.size.equalTo(emailTextField)
        }
        
//        registerLabel.snp.makeConstraints { (view) in
//            view.top.equalTo(loginButton.snp.bottom)
//            view.centerX.equalToSuperview()
//        }
        
        registerButton.snp.makeConstraints { (view) in
            view.top.equalTo(loginButton.snp.bottom).offset(8.0)
            view.centerX.equalToSuperview()
            view.size.equalTo(emailTextField)
        }
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
    }
    
    
    
    
    func login() {

        if let email = emailTextField.text,
            let password = passwordTextField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user: FIRUser?, error: Error?) in
                
                if user != nil {
                    
                    if let tabVC =  self.navigationController {
                        tabVC.show(self.newViewController, sender: nil)
                        
                    }
                } else {
                    
                    self.showAlertFailure(title: "Login Failed!", error: error!)
                }
                
            })
        }
        
//        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        
    }
    
    func register() {
        
        if let email = emailTextField.text,
            let password = passwordTextField.text {
            
            FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user:FIRUser?, error: Error?) in
                
                if error != nil {
                    self.showAlertFailure(title: "Register Failed!", error: error!)
                }
                
                
                if let tabVC =  self.navigationController {
                    tabVC.show(self.newViewController, sender: nil)
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
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        let backgroundImage = UIImage(named: "backgroundPic2")
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
    
    private let loginLogo: UIImageView = {
        var imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emailTextField: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.backgroundColor = .black
        textfield.attributedPlaceholder = NSAttributedString(string: "Email..", attributes: [NSForegroundColorAttributeName: Colors.lightPrimaryColor])
        textfield.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        var paddingView = UIView(frame:CGRect(x: 10, y: 0, width: 30, height: 30))
        textfield.leftView = paddingView
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
    
    private let passwordTextField: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.backgroundColor = .black
        textfield.attributedPlaceholder = NSAttributedString(string: "Password..", attributes: [NSForegroundColorAttributeName: Colors.lightPrimaryColor])
        textfield.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        var paddingView = UIView(frame:CGRect(x: 10, y: 0, width: 30, height: 30))
        textfield.leftView = paddingView
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
        button.backgroundColor =  Colors.brightText
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 14)
        
        return button
    }()
    
    private let registerButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.lightPrimaryColor
        button.titleLabel?.font = UIFont(name: "Avenir Next", size: 14)
        return button
        
    }()
    
//    private let registerLabel: UILabel = {
//        let label: UILabel = UILabel()
//        label.text = "Don't have an account?"
//        label.font = UIFont.systemFont(ofSize: 10)
//        return label
//    }()
    
}

