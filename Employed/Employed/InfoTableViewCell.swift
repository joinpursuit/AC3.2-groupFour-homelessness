//
//  InfoTableViewCell.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String =  "infoCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(){
        let label: UILabel = UILabel()
        label.text = "Blah Blah blah blah"
        self.addSubview(label)
        
        label.snp.makeConstraints { (view) in
            view.trailing.leading.top.bottom.equalToSuperview()
        }
        
    }

}
