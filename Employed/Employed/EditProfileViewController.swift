//
//  EditProfileViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/19/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Edit Profile"
        
        setUpView()
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(dismissme))
        
    }
    
    private func setUpView(){
        self.view.addSubview(profileImage)
        self.edgesForExtendedLayout = []
        
        profileImage.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.4)
            
           
        }
        
    }
    
    func dismissme(){
        dismiss(animated: true, completion: nil)
    }
    
    private let profileImage: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "onepunch")
        return imageView
    }()
    
    
    private let backBarItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem()
        barItem.title = "Back"
        return barItem
    }()
    
    
}
