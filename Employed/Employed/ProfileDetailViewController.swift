//
//  ProfileDetailViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/19/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class ProfileDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white

        setUpViews()
    }

    private func setUpViews(){
        self.view.addSubview(controllerTitle)
        self.view.addSubview(controllerDetail)
        
        self.edgesForExtendedLayout = []
        
        controllerTitle.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(20)
        }
        
        controllerDetail.snp.makeConstraints { (view) in
            view.top.equalTo(controllerTitle.snp.bottom).offset(50)
            view.leading.equalToSuperview().offset(30)
        }
    }
    
    let controllerTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Title"
        label.font = UIFont.systemFont(ofSize: 30, weight: 10)
        return label
    }()
    
    let controllerDetail: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Some random stuff goes here!!"
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()

}
