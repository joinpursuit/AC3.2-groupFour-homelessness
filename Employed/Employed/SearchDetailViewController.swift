//
//  SearchDetailViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController, UINavigationControllerDelegate, UINavigationBarDelegate {
    var jobPost: NYCJobs!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        self.title = jobPost.buisnessTitle
        self.view.backgroundColor = Colors.primaryColorUIColor
        
        let barButton = UIBarButtonItem(customView: saveButton)
        self.navigationItem.rightBarButtonItem = barButton
        
    }
    
    //MARK: - SetupViews
    private func setUpViews(){
        
        self.edgesForExtendedLayout = []
    }
    //MARK: - Utilities
    func savePost() {
        print("save post")
    }
 
    //MARK: - Views
       private lazy var saveButton: UIButton = {
            let button = UIButton(type: UIButtonType.custom)
            button.addTarget(self, action: #selector(savePost), for: .touchUpInside)
            button.setTitle("save", for: .normal)
            button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
            
            return button
        }()


}
