//
//  ViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = .white
        setUpViews()
        
        
    }

  
    
    //MARK:- SetupViews
    func setUpViews(){
        
        self.edgesForExtendedLayout = []
        
        let padding: CGFloat = 40
        
        self.view.addSubview(loginLogo)
        self.view.addSubview(emailTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(loginButton)
        self.view.addSubview(registerLabel)
        self.view.addSubview(registerButton)
        
        loginLogo.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().offset(padding)
        }
        
        emailTextField.snp.makeConstraints { (view) in
            view.top.equalTo(self.loginLogo.snp.bottom).offset(50)
            view.centerX.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.7)
        }
        
        passwordTextField.snp.makeConstraints { (view) in
            view.top.equalTo(self.emailTextField.snp.bottom).offset(padding)
            view.centerX.equalToSuperview()
            view.width.equalToSuperview().multipliedBy(0.7)
        }
        
        loginButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(self.passwordTextField.snp.bottom).offset(padding)
        }
        
        registerLabel.snp.makeConstraints { (view) in
            view.top.equalTo(loginButton.snp.bottom)
            view.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints { (view) in
            view.top.equalTo(registerLabel.snp.bottom)
            view.centerX.equalToSuperview()
        }
        
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        //registerButton.addTarget(self, action: #selector(), for: .touchUpInside)
    }
    
    //MARK: - Utilities
    func login() {
        print("Clicked login")
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - Views
    private let loginLogo: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let emailTextField: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.placeholder = "Email..."
        textfield.backgroundColor = Colors.lightPrimaryColor
        textfield.keyboardType = .emailAddress
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        return textfield
    }()
    
    private let passwordTextField: UITextField = {
        let textfield: UITextField = UITextField()
        textfield.placeholder = "Password..."
        textfield.backgroundColor = Colors.lightPrimaryColor
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    private let loginButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("click here", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
        
    }()
    
    private let registerLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Don't have an account?"
        return label
    }()

}

