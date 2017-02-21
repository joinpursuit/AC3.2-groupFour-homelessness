//
//  ResumePreviewViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseAuth

protocol ResumeShowCamera{
    func showCameraPicker()
}

class ResumePreviewViewController: UIViewController {
    var pdfUrl: URLRequest?
    var delegate: ResumeShowCamera?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: "close"), style: .done, target: self, action: #selector(dismissme))
        
        self.title = "Your R\u{E9}sum\u{E9}"
        
        setUpViews()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webview.loadRequest(pdfUrl!)
    }
    
    func setUpViews(){
        self.view.addSubview(webview)
        self.view.addSubview(acceptButton)
        self.view.addSubview(retakeButton)
        
        self.edgesForExtendedLayout = []
        
   
        webview.snp.makeConstraints { (view) in
           
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.8)
        }
        
        acceptButton.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().inset(20)
            view.trailing.equalTo(self.view.snp.centerX).offset(-20)
            view.width.equalToSuperview().multipliedBy(0.4)
        }
        
        retakeButton.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().inset(20)
            view.leading.equalTo(self.view.snp.centerX).inset(20)
            view.width.equalToSuperview().multipliedBy(0.4)
        }
        acceptButton.addTarget(self, action: #selector(accept), for: .touchUpInside)
        retakeButton.addTarget(self, action: #selector(retake), for: .touchUpInside)
    }
    
    func accept(){
        let storageRef = FIRStorage.storage().reference(forURL: "gs://employed-42a2b.appspot.com").child("ResumePDF")
        let pdfRef = storageRef.child((FIRAuth.auth()?.currentUser?.uid)!)
        
        if let pdfUrl = EmployedFileManager.shared.retreivePDF(){
            
            pdfRef.putFile(pdfUrl, metadata: nil, completion: { (_, error) in
                if error != nil{
                    print("\(error?.localizedDescription)")
                }else{
                    print("PDF SAVED")
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    
    func dismissme(){
        dismiss(animated: true, completion: nil)
    }
    
    func retake(){
        dismiss(animated: true) {
            self.delegate?.showCameraPicker()
        }
    }
    
    private let webview: UIWebView = {
        let webView: UIWebView = UIWebView()
        return webView
    }()
    
    private let acceptButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Accept", for: .normal)
        button.backgroundColor = Colors.accentColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let retakeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Retake", for: .normal)
        button.backgroundColor = Colors.accentColor
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let title: UILabel = UILabel()
        title.text = "R\u{E9}sum\u{E9}"
        title.font = UIFont.systemFont(ofSize: 30, weight: 10)
        return title
    }()
}
