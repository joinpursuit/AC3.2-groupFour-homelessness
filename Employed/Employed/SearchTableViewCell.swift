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
    let companyIcons = ["indeed", "monster", "dice", "glassdoor", ""]
    var jobLabel = UILabel()
    var subLabel = UILabel()
    var agencyLabel = UILabel()
    var companyIcon = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //Labels
        jobLabel.textColor = .black
        jobLabel.font = UIFont.systemFont(ofSize: 14.0, weight: 5.0)
        jobLabel.font = UIFont(name: "Futura", size: jobLabel.font.pointSize)
        jobLabel.sizeToFit()
        jobLabel.adjustsFontSizeToFitWidth = false
        jobLabel.numberOfLines = 2
        jobLabel.textAlignment = .center
        
        agencyLabel.textColor = .black
        jobLabel.font = UIFont(name: "Futura", size: jobLabel.font.pointSize)
        agencyLabel.font = UIFont.systemFont(ofSize: 12)
        
        subLabel.textColor = UIColor.lightGray
        subLabel.font = UIFont.systemFont(ofSize: 12)
        
        let randomIndex = Int(arc4random_uniform(4) + 1)
        companyIcon.image = UIImage(named: companyIcons[randomIndex])
 
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(jobLabel)
        self.contentView.addSubview(subLabel)
        self.contentView.addSubview(agencyLabel)
        self.contentView.addSubview(companyIcon)
        
        
        jobLabel.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(25.0)
            view.leading.equalToSuperview().offset(12.0)
            
        }
        
        agencyLabel.snp.makeConstraints { (view) in
            view.top.equalTo(jobLabel.snp.bottom).offset(5.0)
            view.leading.equalToSuperview().offset(12.0)
            
        }
        
        subLabel.snp.makeConstraints { (view) in
            view.top.equalTo(agencyLabel.snp.bottom).offset(5.0)
            view.leading.equalToSuperview().offset(11.0)
            view.width.equalToSuperview().multipliedBy(0.80)
            
        }
        
        companyIcon.snp.makeConstraints { (view) in
            //view.centerX.equalToSuperview()
            //view.top.equalTo(subLabel.snp.bottom).offset(10.0)
            view.centerY.equalToSuperview()
            view.leading.equalTo(subLabel.snp.trailing).offset(5.0)
        }
    }
    
    
    
    

}
