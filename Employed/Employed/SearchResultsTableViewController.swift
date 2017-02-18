//
//  SearchResultsTableViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

     var jobs = [NYCJobs]()
    
    var sectionTitles: [String] {
        get {
            var sectionSet = Set<String>()
            for job in jobs {
                sectionSet.insert(job.agency)
            }
            return Array(sectionSet).sorted()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        let rightBarButton = UIBarButtonItem(customView: filterButton)
        let leftBarButton = UIBarButtonItem(customView: searchButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Jobs"
        
        
        self.view.backgroundColor = UIColor.green
        getData()
        
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "nycCell")
        tableView.rowHeight = 200
    }
    
    
    //MARK: - Utilities
    func getData() {
        APIRequestManager.manager.getPOD(endPoint: "https://data.cityofnewyork.us/resource/swhp-yxa4.json") { (data) in
            
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []),
                    let validJob = jsonData as? [[String:Any]] {
                    
                    self.jobs = NYCJobs.getJobs(from: validJob)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }


    //MARK: - SetupViews
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
        
        self.view.addSubview(filterButton)
        self.view.addSubview(searchButton)
    }
    
    func filterButtonPressed(sender: UIButton) {
        print("filter pressed")
    }
    
    func searchButtonPressed(sender: UIButton) {
        print("search pressed")
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobs.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nycCell", for: indexPath) as! SearchTableViewCell
        
        
        let selectedCell = jobs[indexPath.row]
        cell.jobLabel.text = selectedCell.buisnessTitle
        cell.subLabel.text = "\(selectedCell.agency) • Posted \(selectedCell.postingDate)"
        
        return cell
    }
    

    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        let searchDetailVc = SearchDetailViewController()
        searchDetailVc.jobPost = jobs[selectedRow]
        
        navigationController?.pushViewController(searchDetailVc, animated: true)
    }
    
    
    internal lazy var filterButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(filterButtonPressed(sender:)), for: .touchUpInside)
        button.setTitle("Filter", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        return button
    }()
    
    internal lazy var searchButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(searchButtonPressed(sender:)), for: .touchUpInside)
        button.setTitle("Search", for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        return button
    }()
    
//    internal lazy var searchField: UISearchBar = {
//        let search = UISearchBar()
//        
//        
//    }()


    
}
