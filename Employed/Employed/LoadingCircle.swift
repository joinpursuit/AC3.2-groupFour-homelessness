//
//  LoadingCircle.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/21/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class LoadingCircle: UIView {

    private let colorarray: [UIColor] = [Colors.accentColor,Colors.darkPrimaryColor,Colors.dividerColor]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    func setUpview(){
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        self.snp.makeConstraints { (view) in
            view.size.equalTo(CGSize(width: 10, height: 10))
        }
        
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(changeColor), userInfo: nil, repeats: true)
    }

    func changeColor(){
        let random = Int(arc4random_uniform(UInt32(colorarray.count)))
        
        UIView.animate(withDuration: 0.5) {
            self.backgroundColor = self.colorarray[random]
        }
    }
}
