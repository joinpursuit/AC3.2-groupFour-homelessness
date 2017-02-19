//
//  ResumePreviewViewController.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/18/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit

class ResumePreviewViewController: UIViewController {
    var pdfUrl: URLRequest?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        webview.loadRequest(pdfUrl!)
    }
    
    func setUpViews(){
        self.view.addSubview(webview)
        self.view.addSubview(acceptButton)
        self.view.addSubview(retakeButton)
        
        
        webview.snp.makeConstraints { (view) in
            view.top.leading.trailing.equalToSuperview()
            view.height.equalToSuperview().multipliedBy(0.9)
        }
        
        acceptButton.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().inset(20)
            view.trailing.equalTo(self.view.snp.centerX).offset(-20)
        }
        
        retakeButton.snp.makeConstraints { (view) in
            view.bottom.equalToSuperview().inset(20)
            view.leading.equalTo(self.view.snp.centerX).inset(20)
        }
        
        retakeButton.addTarget(self, action: #selector(retake), for: .touchUpInside)
    }
    
    func accept(){
        print("Accept")
    }
    
    func retake(){
        dismiss(animated: true, completion: nil)
    }
    
    private let webview: UIWebView = {
        let webView: UIWebView = UIWebView()
        return webView
    }()
    
    private let acceptButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Accept", for: .normal)
        return button
    }()
    
    private let retakeButton: UIButton = {
        let button: UIButton = UIButton()
        button.setTitle("Retake", for: .normal)
        return button
    }()
}
