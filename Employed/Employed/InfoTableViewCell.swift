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
        
        self.selectionStyle = .none
        
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell(){
        
        self.addSubview(cellIcon)
        self.addSubview(cellDetail)
        self.addSubview(cellTitle)
        
        cellIcon.snp.makeConstraints { (view) in
            view.centerY.equalToSuperview()
            view.leading.equalToSuperview().offset(10)
        }
        
        cellTitle.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(10)
            view.leading.equalTo(cellIcon.snp.trailing).offset(10)
        }
        
        cellDetail.snp.makeConstraints { (view) in
            view.top.equalTo(cellTitle.snp.bottom)
            view.leading.equalTo(cellIcon.snp.trailing).offset(10)
            view.bottom.equalToSuperview().inset(10)
        }
    }
    
    let cellIcon: UIImageView = {
        let imageview: UIImageView = UIImageView()
        imageview.image = UIImage(named: "user")
        return imageview
    }()
    
    let cellDetail: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Some description goes here..."
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    let cellTitle: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Title"
        //label.font = UIFont.boldSystemFont(ofSize: 20)
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        return label
    }()
    
}
