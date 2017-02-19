//
//  SearchTableViewCell.swift
//  Employed
//
//  Created by Kadell on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    var jobLabel = UILabel()
    var subLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Labels
        jobLabel.textColor = Colors.darkPrimaryColor
        jobLabel.font = UIFont.systemFont(ofSize: 16.0, weight: 2.0)
        jobLabel.sizeToFit()
        jobLabel.textAlignment = .center
        
        subLabel.textColor = UIColor.lightGray
        subLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(jobLabel)
        self.contentView.addSubview(subLabel)
        
        
        jobLabel.snp.makeConstraints { (view) in
            view.width.equalToSuperview().offset(16.0)
            view.height.equalTo(50)
            view.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { (view) in
            view.width.equalTo(jobLabel.snp.width)
            view.height.equalTo(50)
            view.top.equalTo(jobLabel.snp.bottom)
            view.trailing.equalTo(jobLabel.snp.trailing)
        }
    }
    
    
    
    

}
