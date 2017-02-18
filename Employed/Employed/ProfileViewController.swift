//
//  ProfileViewController.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //MARK: -Views
    
    internal let profilePic: UIImageView = {
        let image = UIImageView()
        
        image.layer.cornerRadius = 0.3
        image.isUserInteractionEnabled = true
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.4
        image.layer.shadowOffset = CGSize(width: 1, height: 5)
        image.layer.shadowRadius = 2
        image.contentMode = .scaleAspectFit
        
        return image
    
    }()
}
