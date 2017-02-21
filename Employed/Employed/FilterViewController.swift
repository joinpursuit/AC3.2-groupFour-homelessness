//
//  FilterViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/21/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(dismissme))
        setupViewHierarchy()
        

    }
    
    func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
    func dismissme(){
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - SetupViews
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(mySegmentedControl)
        
        mySegmentedControl.addTarget(self, action: #selector(FilterViewController.segmentedValueChanged(_:)), for: .valueChanged)
        
    }
    


    //MARK: - Views
    private let mySegmentedControl: UISegmentedControl = {
        var mySegmentedControl = UISegmentedControl(items: ["Distance","Date","Wage"])
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        mySegmentedControl.selectedSegmentIndex = 1
        mySegmentedControl.tintColor = UIColor.yellow
        mySegmentedControl.backgroundColor = UIColor.black
        return mySegmentedControl
    }()
    
    private let applyChangesButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("Apply Changes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.darkPrimaryColor
        return button
    }()
    
    private let greetingLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .white
        label.text = "What Job are you looking for?"
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    
}
