//
//  FilterViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/21/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    let step:Float = 5
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.lightPrimaryColor
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissme))
        setupViewHierarchy()
        
        self.segmentLabel.text = "Sort based on:"
        self.sliderLabel2.text = "Min pay per hour:"
        

    }
    //MARK: - Utilities
    func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
    func sliderValueDidChange(_ sender:UISlider!)
    {
        print("Slider value changed")
        
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value / step) * step
        sender.value = roundedStepValue
        
        sliderLabel.text = "At least $\(Int(roundedStepValue))/hour"
        print("Slider step value \(Int(roundedStepValue))")
    }
    
    func dismissme() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - SetupViews
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(segmentLabel)
        self.view.addSubview(mySegmentedControl)
        self.view.addSubview(mySlider)
        self.view.addSubview(sliderLabel2)
        self.view.addSubview(sliderLabel)
        
        mySegmentedControl.addTarget(self, action: #selector(FilterViewController.segmentedValueChanged(_:)), for: .valueChanged)
        
        segmentLabel.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(24)
            view.width.equalToSuperview()
            view.leading.equalToSuperview().offset(24)
        }
        
        mySegmentedControl.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(segmentLabel.snp.bottom)
        }
        
        sliderLabel2.snp.makeConstraints { (view) in
            view.leading.equalTo(segmentLabel)
            view.width.equalTo(segmentLabel)
            view.top.equalTo(mySegmentedControl.snp.bottom).offset(16)
        }
        
        mySlider.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalTo(sliderLabel2.snp.bottom).offset(10)
            view.width.equalTo(300)
            view.height.equalTo(20)
        }
        
        sliderLabel.snp.makeConstraints { (view) in
            view.top.equalTo(mySlider.snp.bottom).offset(10)
            view.center.equalToSuperview()
            view.width.equalTo(mySlider)
        }
        
    }
    


    //MARK: - Views
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.darkPrimaryColor
        return view
    }()
    
    private let segmentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let mySegmentedControl: UISegmentedControl = {
        var mySegmentedControl = UISegmentedControl(items: ["Distance","Date","Wage"])
        let xPostion:CGFloat = 10
        let yPostion:CGFloat = 150
        let elementWidth:CGFloat = 300
        let elementHeight:CGFloat = 30
        mySegmentedControl.frame = CGRect(x: xPostion, y: yPostion, width: elementWidth, height: elementHeight)
        mySegmentedControl.selectedSegmentIndex = 1
        mySegmentedControl.tintColor = Colors.accentColor
        mySegmentedControl.backgroundColor = UIColor.white
        return mySegmentedControl
    }()

    
    private let mySlider: UISlider = {
        var mySlider = UISlider()
        mySlider.minimumValue = 0
        mySlider.maximumValue = 100
        mySlider.isContinuous = true
        mySlider.tintColor = Colors.accentColor
        mySlider.addTarget(self, action: #selector(FilterViewController.sliderValueDidChange(_:)), for: .valueChanged)
        return mySlider
    }()
    
    private let sliderLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let sliderLabel2: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 16.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    //
    private let applyChangesButton: UIButton = {
        let button: UIButton = UIButton(type: .roundedRect)
        button.setTitle("Apply Changes", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.darkPrimaryColor
        return button
    }()
    
  
    
    
    
}
