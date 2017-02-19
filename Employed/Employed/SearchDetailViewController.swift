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

class SearchDetailViewController: UIViewController, UINavigationControllerDelegate, UINavigationBarDelegate {
    var jobPost: NYCJobs!

    var scrollView: UIScrollView!



    var databaseReference = FIRDatabase.database().reference()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        
        self.title = jobPost.buisnessTitle
        self.view.backgroundColor = Colors.lightPrimaryColor
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.addSubview(container)
        scrollView.contentSize = container.bounds.size
        view.addSubview(scrollView)
        
        let barButton = UIBarButtonItem(customView: saveButton)
        self.navigationItem.rightBarButtonItem = barButton
        
        //Job Detail profile
        self.jobTitle.text = jobPost.buisnessTitle
        self.agencyLabel.text = jobPost.agency.lowercased()
        self.addressLabel.text = jobPost.workLocation
        self.addressLabel.addImage(imageName: "marker")
        self.wageLabel.text = "$40,000"
        self.jobPostDescription.text = jobPost.jobDescription
        self.jobReqs.text = jobPost.minReqs
        
        //"Category" labels
        self.wageCategoryLabel.text = "SALARY "
    }
    
    //testdkmfslkfm
    
    //MARK: - SetupViews
    func setUpViews(){
        //self.view.addSubview(scrollView)
        //self.scrollView.addSubview(container)
//        self.view.addSubview(jobTitle)
//        self.view.addSubview(agencyLabel)
//        self.view.addSubview(addressLabel)
//        self.view.addSubview(wageCategoryLabel)
//        self.view.addSubview(wageLabel)
//        self.view.addSubview(jobPostDescription)
//        self.view.addSubview(jobReqs)
//        self.view.addSubview(mapView)
        self.view.addSubview(container)
        self.container.addSubview(jobTitle)
        self.container.addSubview(agencyLabel)
        self.container.addSubview(addressLabel)
        self.container.addSubview(wageCategoryLabel)
        self.container.addSubview(wageLabel)
        self.container.addSubview(jobPostDescription)
        self.container.addSubview(jobReqs)
        self.container.addSubview(mapView)
        
        self.edgesForExtendedLayout = []
        
//        scrollView.snp.makeConstraints { (view) in
//            view.leading.trailing.equalTo(container)
//            view.height.width.equalTo(container)
//        }
        
        container.snp.makeConstraints { (view) in
            view.top.bottom.leading.trailing.equalToSuperview()
        }
        
        jobTitle.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(8.0)
            view.leading.equalToSuperview().offset(16.0)
        }
        
        agencyLabel.snp.makeConstraints { (view) in
            view.top.equalTo(jobTitle.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        addressLabel.snp.makeConstraints { (view) in
            view.top.equalTo(agencyLabel.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        wageCategoryLabel.snp.makeConstraints { (view) in
            view.top.equalTo(addressLabel.snp.bottom).offset(8.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        wageLabel.snp.makeConstraints { (view) in
            view.top.equalTo(addressLabel.snp.bottom).offset(8.0)
            view.trailing.equalTo(addressLabel.snp.trailing)
        }
        
        jobPostDescription.snp.makeConstraints { (view) in
            view.top.equalTo(wageLabel.snp.bottom).offset(16.0)
            view.centerX.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.5)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        jobReqs.snp.makeConstraints { (view) in
            view.top.equalTo(jobPostDescription.snp.bottom).offset(16.0)
            view.leading.equalTo(jobTitle.snp.leading)
        }
        
        mapView.snp.makeConstraints { (view) in
            view.top.equalTo(jobReqs.snp.bottom).offset(16.0)
            view.centerX.equalToSuperview()
            view.width.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.25)
        }
        
    }

    //MARK: - Utilities
    func savePost() {
        
        
        let dict = jobPost.asDictionary
        let userData = databaseReference.child("SavedJobs").child((FIRAuth.auth()?.currentUser?.uid)!).childByAutoId()
        
        userData.updateChildValues(dict)
        
        
        
        let alert = UIAlertController(title: "Saved job post!", message: "This is now in your saved list.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Views
    private lazy var container: UIView = {
        let view = UIView()
        view.frame = UIScreen.main.bounds
        return view
    }()
    
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        return scrollView
//    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(savePost), for: .touchUpInside)
        button.setTitle("Save", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        
        return button
    }()
    
    private lazy var jobTitle: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: 12.0)
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
    
    private lazy var wageCategoryLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = Colors.darkPrimaryColor
        return label
    }()
    
    private lazy var wageLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    
    private lazy var jobPostDescription: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont(name: "San Francisco", size: label.font.pointSize)
         label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var jobReqs: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.font = UIFont(name: "San Francisco", size: label.font.pointSize)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let mapView: UIImageView = {
        let image = UIImageView()
        let backgroundImage = UIImage(named: "map")
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        return image
    }()
    

    
}
