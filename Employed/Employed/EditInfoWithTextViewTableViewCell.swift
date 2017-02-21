//
//  EditInfoWithTextViewTableViewCell.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/20/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class EditInfoWithTextViewTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "TextViewCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell(){
        
        self.addSubview(cellTitle)
        self.addSubview(cellTextView)
        
        self.selectionStyle = .none
        
        cellTitle.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(15)
        }
        
        cellTextView.snp.makeConstraints { (view) in
            view.top.equalTo(cellTitle.snp.bottom).offset(15)
            view.height.equalTo(50)
            view.leading.equalToSuperview().offset(15)
            view.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    let cellTitle: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let cellTextView: UITextView = {
        let textView: UITextView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.lightGray.cgColor
        return textView
    }()

}
