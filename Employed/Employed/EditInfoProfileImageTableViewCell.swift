//
//  EditInfoProfileImageTableViewCell.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/20/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class EditInfoProfileImageTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "imageViewCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(profileImage)
        
        profileImage.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
            view.height.equalTo(250)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let profileImage: UIImageView = {
        let imageview: UIImageView = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.layer.masksToBounds = true
        imageview.isUserInteractionEnabled = true
        return imageview
    }()
    
}
