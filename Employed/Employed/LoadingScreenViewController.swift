//
//  LoadingScreenViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/21/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

protocol LoadingScreen {
    func hideScreen()
}

class LoadingScreenViewController: UIViewController,LoadingScreen {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .clear

        setUpView()
    }

   func setUpView(){
    
    self.view.addSubview(tintBackground)
    self.view.addSubview(leftCircle)
    self.view.addSubview(rightCircle)
    self.view.addSubview(centerCircle)
    
    
    tintBackground.snp.makeConstraints { (view) in
        view.top.leading.trailing.bottom.equalToSuperview()
    }
    
    leftCircle.snp.makeConstraints { (view) in
        view.centerY.equalToSuperview()
        view.trailing.equalTo(centerCircle.snp.leading)
    }
    
    centerCircle.snp.makeConstraints { (view) in
        view.centerY.centerX.equalToSuperview()
    }
    
    rightCircle.snp.makeConstraints { (view) in
        view.leading.equalTo(centerCircle.snp.trailing)
        view.centerY.equalToSuperview()
    }
    
    }
    
    func hideScreen() {
        dismiss(animated: true, completion: nil)
    }
    
    private let tintBackground: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black
        view.alpha = 0.2
        return view
    }()
    
    private let leftCircle: LoadingCircle = LoadingCircle()
    private let centerCircle: LoadingCircle = LoadingCircle()
    private let rightCircle: LoadingCircle = LoadingCircle()
    

}
