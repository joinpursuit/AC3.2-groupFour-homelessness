//
//  CameraOverlayBarView.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/19/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class CameraOverlayBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUpBar(){
        
        self.addSubview(verticalBar)
        self.addSubview(horizontalBar)
        
        let width: CGFloat = 5
        let length: CGFloat = 30
        
        self.snp.makeConstraints { (view) in
            view.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        verticalBar.snp.makeConstraints { (view) in
            view.leading.top.equalToSuperview()
            view.size.equalTo(CGSize(width: width, height: length))
        }
        
        horizontalBar.snp.makeConstraints { (view) in
            view.leading.top.equalToSuperview()
            view.size.equalTo(CGSize(width: length, height: width))
        }
        
    }
    
    private let verticalBar: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    private let horizontalBar: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .red
        return view
        
    }()

}
