//
//  SearchResultsTableViewController.swift
//  Employed
//
//  Created by Ilmira Estil on 2/17/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    var jobs = [NYCJobs]()
    public var oldJobs = [NYCJobs]()
    var filteredJobs = [NYCJobs]()
    var leftBarButton = UIBarButtonItem()
    var rightBarButton = UIBarButtonItem()
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
        setupViewHierarchy()
        
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(image: UIImage(named: "filter"), style: .done, target: self, action: #selector(filterButtonPressed(sender:)))
        self.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: UIImage(named: "search25"), style: .done, target: self, action: #selector(searchButtonPressed(sender:)))
        
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.title = "Jobs"
        
        self.view.backgroundColor = Colors.backgroundColor
        getData()
        
        self.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "nycCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = 100
        tableView.estimatedRowHeight = 200
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refilter()
        self.tableView.reloadData()
    }
    
    func refilter() {
        jobs.sort { (job, job1) -> Bool in
            return job.postingDate > job1.postingDate
        }
    }

    
    //MARK: - Utilities
    func getData() {
        APIRequestManager.manager.getPOD(endPoint: "https://data.cityofnewyork.us/resource/swhp-yxa4.json") { (data) in
            
            if let validData = data {
                if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []),
                    let validJob = jsonData as? [[String:Any]] {
                    
                    self.jobs = NYCJobs.getJobs(from: validJob)
                    self.oldJobs = NYCJobs.getJobs(from: validJob)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }

    /*
    func getData(_ searchText: String) {
            APIRequestManager.manager.getPOD(endPoint: "http://service.dice.com/api/rest/jobsearch/v1/simple.json?&city=New+York,+NY") { (data) in
    
                if let validData = data {
                    if let jsonData = try? JSONSerialization.jsonObject(with: validData, options: []),
                        let validJob = jsonData as? [String:Any] {
    
                        self.jobs = DiceJob.getJobs(from: validJob)
    
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
    
                }
            }
        }
 */
    
    func searchJob(_ filter: String) {
        self.jobs = jobs.filter {
            return $0.buisnessTitle.lowercased().contains(filter.lowercased())
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchJob(searchText)
        self.tableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.jobs = self.oldJobs
        self.tableView.reloadData()
    }
    

    
    //MARK: - SetupViews
    func setupViewHierarchy() {
        self.edgesForExtendedLayout = []
//        self.view.addSubview(filterButton)
//        self.view.addSubview(searchButton)
    
    }
    
    func filterButtonPressed(sender: UIButton) {
        print("filter pressed")
        let filterVC = UINavigationController(rootViewController: FilterViewController())
        self.navigationController?.present(filterVC, animated: true, completion: nil)
        
    }
    
    func searchButtonPressed(sender: UIButton) {
        print("search pressed")
        self.navigationItem.titleView = searchField
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.leftBarButtonItem = nil
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = rightBarButton
        self.navigationItem.leftBarButtonItem = leftBarButton
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
        
            
        var chars = Array((selectedCell.agency).characters)
        let firstChar = String(chars[0]).uppercased()
        let rest = String(chars[1..<chars.count]).lowercased()
        cell.agencyLabel.text = "\(firstChar)\(rest)"
        
        
        cell.subLabel.text = "\(selectedCell.workLocation) • Posted \(selectedCell.postingDate)"
        cell.subLabel.addImage(imageName: "marker25")
 
        //cell.textLabel?.text = selectedCell.jobTitle

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
        button.setImage(UIImage(named: "filter"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        return button
    }()
    
    internal lazy var searchButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom)
        button.addTarget(self, action: #selector(searchButtonPressed(sender:)), for: .touchUpInside)
        button.setImage(UIImage(named: "search25"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        return button
    }()
    
    internal lazy var searchField: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchBar.placeholder = " Search..."
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        return searchBar
    }()
}

