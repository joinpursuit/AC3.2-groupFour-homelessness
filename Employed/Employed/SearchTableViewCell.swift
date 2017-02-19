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
    var agencyLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Labels
        jobLabel.textColor = .black
        jobLabel.font = UIFont.systemFont(ofSize: 18.0, weight: 10.0)
        jobLabel.sizeToFit()
        jobLabel.adjustsFontSizeToFitWidth = true
        jobLabel.numberOfLines = 2
        jobLabel.textAlignment = .center
        
        agencyLabel.textColor = .black
        agencyLabel.font = UIFont.systemFont(ofSize: 14)
        
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
        self.contentView.addSubview(agencyLabel)
        
        
        jobLabel.snp.makeConstraints { (view) in
            view.height.equalTo(50)
            view.trailing.leading.equalToSuperview().offset(8.0)
        }
        
        agencyLabel.snp.makeConstraints { (view) in
            view.width.equalTo(jobLabel.snp.width)
            view.height.equalTo(20)
            view.centerX.equalToSuperview()
            view.top.equalTo(jobLabel.snp.bottom).offset(8.0)
            view.leading.equalTo(jobLabel.snp.leading).offset(16.0)
        }
        
        subLabel.snp.makeConstraints { (view) in
            view.width.equalTo(agencyLabel.snp.width)
            view.height.equalTo(20)
            view.top.equalTo(agencyLabel.snp.bottom).offset(16.0)
            view.leading.equalTo(jobLabel.snp.leading).offset(16.0)
        }
    }
    
    
    
    

}
