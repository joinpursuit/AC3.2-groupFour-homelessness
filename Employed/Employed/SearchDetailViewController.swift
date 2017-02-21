//
//  SearchDetailViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseDatabase
import FirebaseAuth
import MapKit
import SCLAlertView

class SearchDetailViewController: UIViewController, UINavigationControllerDelegate, UINavigationBarDelegate, UIScrollViewDelegate {
    var jobPost: NYCJobs!
    var wageArray = ["$60,000","$82,000","$68,000","$100,000","$49,000","$77,000","$75,000","$87,000","$102,000","$140,000"]
    //var scrollView: UIScrollView!
    var randomNumber = Int(arc4random_uniform(9))
    var databaseReference = FIRDatabase.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        self.title = jobPost.buisnessTitle
        self.view.backgroundColor = .white
 
        let barButton = UIBarButtonItem(customView: saveButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        //Job Detail profile
        self.jobTitle.text = "\(jobPost.buisnessTitle) - Part-time"
        
        var chars = Array((jobPost.agency).characters)
        let firstChar = String(chars[0]).uppercased()
        let rest = String(chars[1..<chars.count]).lowercased()
        self.agencyLabel.text = "\(firstChar)\(rest)"
        
        self.addressLabel.text = jobPost.workLocation
        self.addressLabel.addImage(imageName: "marker25")
        self.wageLabel.text = wageArray[randomNumber]
//        "$40,000"
        self.jobPostDescription.text = "\(jobPost.jobDescription)..."
        
        self.jobReqs.text = jobPost.minReqs
        
        
        //"Category" labels
        self.wageCategoryLabel.text = "SALARY"
        self.agencyCategoryLabel.text = "ABOUT \(jobPost.agency)"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
    }
    
    

    //MARK: - SetupViews
    func setUpViews(){
        self.view.addSubview(scrollView)
        self.view.addSubview(applyNowButton)
        self.scrollView.addSubview(container)
        self.container.addSubview(topSeparator)
        self.container.addSubview(topSeparatorB)
        self.container.addSubview(midSeparator)
        self.container.addSubview(bottomSeparator)
        self.container.addSubview(jobTitle)
        self.container.addSubview(agencyLabel)
        self.container.addSubview(addressLabel)
        self.container.addSubview(wageCategoryLabel)
        self.container.addSubview(wageLabel)
        self.container.addSubview(agencyCategoryLabel)
        self.container.addSubview(jobPostDescription)
        self.container.addSubview(requirementCategoryLabel)
        self.container.addSubview(jobReqs)
        self.container.addSubview(mapView)
        
        self.edgesForExtendedLayout = []
        
        scrollView.snp.makeConstraints { (view) in
            //view.top.leading.trailing.bottom.equalToSuperview()
            view.top.leading.trailing.equalToSuperview()
            view.bottom.equalTo(applyNowButton.snp.top)
            view.width.equalToSuperview()

        }
        
        container.snp.makeConstraints { (view) in
            view.width.equalTo(self.view.snp.width)
            view.centerX.equalTo(self.view.snp.centerX)
            view.top.bottom.equalToSuperview()
            view.leading.trailing.equalToSuperview()
            
        }
        
        topSeparator.snp.makeConstraints { (view) in
            view.width.equalToSuperview().offset(24.0)
            view.height.equalTo(1)
            view.top.equalTo(addressLabel.snp.bottom).offset(5.0)
        }
        
        topSeparatorB.snp.makeConstraints { (view) in
            view.width.equalToSuperview().offset(5.0)
            view.height.equalTo(1)
            view.top.equalTo(wageCategoryLabel.snp.bottom).offset(5.0)
        }
        
        midSeparator.snp.makeConstraints { (view) in
            view.width.equalToSuperview().offset(5.0)
            view.height.equalTo(3)
            view.top.equalTo(jobPostDescription.snp.bottom).offset(8.0)
        }
        
        bottomSeparator.snp.makeConstraints { (view) in
            view.width.equalToSuperview().offset(5.0)
            view.height.equalTo(3)
            view.top.equalTo(jobReqs.snp.bottom).offset(8.0)
        }
        
        addressLabel.snp.makeConstraints { (view) in
            view.top.equalTo(agencyLabel.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        jobTitle.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(8.0)
            view.leading.equalToSuperview().offset(16.0)
            
        }
        
        agencyLabel.snp.makeConstraints { (view) in
            view.top.equalTo(jobTitle.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        
        wageCategoryLabel.snp.makeConstraints { (view) in
            view.top.equalTo(addressLabel.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        wageLabel.snp.makeConstraints { (view) in
            view.top.equalTo(addressLabel.snp.bottom).offset(8.0)
            view.trailing.equalTo(jobPostDescription.snp.trailing)
        }
        
        agencyCategoryLabel.snp.makeConstraints { (view) in
            view.top.equalTo(topSeparatorB.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
            view.width.equalToSuperview()
        }
        
        jobPostDescription.snp.makeConstraints { (view) in
            view.top.equalTo(agencyCategoryLabel.snp.bottom).offset(16.0)
            view.centerX.equalToSuperview()
            //view.height.equalToSuperview().multipliedBy(0.5)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        requirementCategoryLabel.snp.makeConstraints { (view) in
            view.top.equalTo(midSeparator.snp.bottom).offset(8.0)
                view.leading.equalTo(jobTitle.snp.leading)
        }
        
        jobReqs.snp.makeConstraints { (view) in
            view.top.equalTo(requirementCategoryLabel.snp.bottom).offset(16.0)
            view.leading.equalTo(jobTitle.snp.leading)
            view.trailing.equalTo(jobTitle.snp.trailing)
            view.width.equalTo(jobTitle.snp.width)
            view.centerX.equalToSuperview()
        }
        
        mapView.snp.makeConstraints { (view) in
            view.top.equalTo(bottomSeparator.snp.bottom).offset(100.0)
            view.centerX.equalToSuperview()
            view.leading.trailing.equalToSuperview()
            view.width.equalToSuperview()
            view.height.equalTo(100)
        }
        
        applyNowButton.snp.makeConstraints { (view) in
            view.bottom.trailing.leading.equalToSuperview()
            view.top.equalTo(container.snp.bottom)
            view.height.equalTo(50)
        }
        
        
        
    }

    //MARK: - Utilities
    func savePost() {
        
        if FIRAuth.auth()?.currentUser != nil {
        let dict = jobPost.asDictionary
        let userData = databaseReference.child("SavedJobs").child((FIRAuth.auth()?.currentUser?.uid)!).childByAutoId()
        
        userData.updateChildValues(dict)
        
    
        let alert = UIAlertController(title: "Saved job post!", message: "This is now in your saved list.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
            
        } else {
         Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(switchTab), userInfo: nil, repeats: false)
        }
    }
    
    func applyToJob() {
        if FIRAuth.auth()?.currentUser != nil {
        let editVC = UINavigationController(rootViewController: EditProfileTableViewController())
        self.navigationController?.present(editVC, animated: true, completion: nil)
            
            let dict = jobPost.asDictionary
           let userData =  databaseReference.child("Applied Jobs").child((FIRAuth.auth()?.currentUser?.uid)!).childByAutoId()
            userData.updateChildValues(dict)
            
        } else {
            Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(switchTab), userInfo: nil, repeats: false)
            
        }
    }
    
    func switchTab() {
    tabBarController?.selectedIndex = 2
    
        SCLAlertView().showTitle(
            "Sign In to Apply",
            subTitle: "",
            style: .notice ,
            closeButtonTitle: "Done",
            colorStyle: 0xE6279,
            colorTextButton: 0xFFFFFF
        )
    }
    
    func tappedMap() {
        print("Tapped map")
        let latitude: CLLocationDegrees = 37.2
        let longitude: CLLocationDegrees = 22.9
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Place Name"
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    
    //MARK: - Views
    private lazy var container: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.darkPrimaryColor
        return view
    }()
    
    private lazy var topSeparatorB: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.darkPrimaryColor
        return view
    }()
    
    private lazy var midSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.darkPrimaryColor
        return view
    }()
    
    private lazy var bottomSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.darkPrimaryColor
        return view
    }()
    
    //Labels
    
    private lazy var agencyCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Colors.darkPrimaryColor
        return label
    }()
    
    private lazy var requirementCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = Colors.darkPrimaryColor
        label.text = "REQUIREMENTS"
        return label
    }()
    
    
    private lazy var wageCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: 5.0)
        label.textColor = Colors.darkPrimaryColor
        return label
    }()
    
    
    private lazy var jobTitle: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 6.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        return label
    }()
    
    private lazy var agencyLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    
    private lazy var wageLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    
    private lazy var jobPostDescription: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: 5.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var jobReqs: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: 5.0)
        label.font = UIFont(name: "Avenir Next", size: label.font.pointSize)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let mapView: UIImageView = {
        let image = UIImageView()
        let backgroundImage = UIImage(named: "map")
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedMap))
        tap.delaysTouchesBegan = true
        tap.numberOfTouchesRequired = 1
        image.addGestureRecognizer(tap)
        return image
    }()
    
    //Buttons
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(savePost), for: .touchUpInside)
        button.setImage(UIImage(named: "save2"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        
        return button
    }()
    
    private lazy var applyNowButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(applyToJob), for: .touchUpInside)
        button.setTitle("APPLY NOW", for: .normal)
        button.backgroundColor = Colors.accentColor
        return button
    }()
    
}


