//
//  CameraOverlayView.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class CameraOverlayView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    private func setUpView(){
        self.addSubview(topRight)
        self.addSubview(bottomRight)
        self.addSubview(topLeft)
        self.addSubview(bottomLeft)
        
        topLeft.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(150)
            view.leading.equalToSuperview()
        }
        
        topRight.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(150)
            view.trailing.equalToSuperview()
        }
        
        bottomLeft.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().inset(150)
            view.leading.equalToSuperview()
        }
        
        bottomRight.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().inset(150)
            view.trailing.equalToSuperview()
        }
        
        bottomLeft.transform = CGAffineTransform(rotationAngle: (3 * CGFloat.pi) / 2) //270
        topRight.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2) //90 Degrees
        bottomRight.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    }
    
    private let topRight: CameraOverlayBar = CameraOverlayBar()
    private let bottomRight: CameraOverlayBar = CameraOverlayBar()
    private let topLeft: CameraOverlayBar = CameraOverlayBar()
    private let bottomLeft: CameraOverlayBar = CameraOverlayBar()
    
    
}
