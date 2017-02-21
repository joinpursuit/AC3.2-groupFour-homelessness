//
//  EditInfoWithTextFieldTableViewCell.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/20/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class EditInfoWithTextFieldTableViewCell: UITableViewCell {
    static let cellIdentifier: String = "infoCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCell(){
        
        self.addSubview(cellTitle)
        self.addSubview(cellTextField)
        
        self.selectionStyle = .none
        
        cellTitle.snp.makeConstraints { (view) in
            view.top.leading.equalToSuperview().offset(15)
        }
        
        cellTextField.snp.makeConstraints { (view) in
            view.top.equalTo(cellTitle.snp.bottom).offset(10)
            view.leading.equalToSuperview().offset(15)
            view.bottom.trailing.equalToSuperview().inset(10)
        }
    }
    
    let cellTitle: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let cellTextField: UITextField = {
        let textfield: UITextField = UITextField()
        return textfield
    }()
    
}
